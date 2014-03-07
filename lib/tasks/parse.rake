namespace :skyway do
  desc 'Scrape all shows'
  task :scrape => :environment do
    require 'mechanize'

    (2010..2014).each do |year|
      mech = Mechanize.new
      mech.get("http://aqueousband.com/setlists/#{year}/main.php") do |page|
        page.links_with(:href => /_/).each do |link|
          show = link.click

          puts
          puts "*"*80
          puts "*** VENUE"
          puts venue = show.at(".setlist_setlist h1:first").remove.text
          puts "*** CITY"
          venue_info = show.at(".setlist_setlist h5:first").remove
          puts city = venue_info.children[0].text
          puts "*** DATE"
          puts performed_at = venue_info.children[1..-1].text
          puts "*** SETLIST"
          puts raw_setlist = show.at(".setlist_setlist").text.strip.gsub("\t", "").gsub("\r\n\r\n", "\n").gsub("\r\n", "\n")
          puts
        end
      end
    end
  end
end
