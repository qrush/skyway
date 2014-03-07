namespace :skyway do
  desc 'Scrape all shows'
  task :scrape => :environment do
    require 'mechanize'

    shows = []

    (2010..2014).each do |year|
      mech = Mechanize.new
      mech.get("http://aqueousband.com/setlists/#{year}/main.php") do |page|
        page.links_with(:href => /_/).each do |link|
          show = link.click

          data = {year: year}
          data[:venue] = show.at(".setlist_setlist h1:first").remove.text

          venue_info = show.at(".setlist_setlist h5:first").remove
          data[:city] = venue_info.children[0].text
          data[:performed_at] = venue_info.children[1..-1].text
          data[:raw_setlist] = show.at(".setlist_setlist").text.strip.gsub("\t", "").gsub("\r\n\r\n", "\n").gsub("\r\n", "\n")

          puts "#{year}: #{data[:venue]}"
          shows << data
        end
      end
    end

    File.write("shows.json", JSON.dump(shows))
  end
end
