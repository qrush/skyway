base_url = "https://#{request.host_with_port}/"

xml.instruct! :xml, :version=>"1.0"
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:image' => 'http://www.google.com/schemas/sitemap-image/1.1', 'xmlns:video' => 'http://www.google.com/schemas/sitemap-video/1.1' do
  xml.url do
    xml.loc base_url
    xml.changefreq 'daily'
    xml.priority 0.8
    xml.lastmod sitemap_date(Announcement.last)
  end
  @pages.each do |page|
    xml.url do
      xml.loc page_url(page)
      xml.changefreq 'weekly'
      xml.priority 0.7
    end
  end
  cache @shows do
    @shows.each do |show|
      xml.url do
        xml.loc show_url(show)
        xml.changefreq 'weekly'
        xml.priority 0.6
        xml.lastmod sitemap_date(show)
      end
    end
  end
  cache @songs do
    @songs.each do |song|
      xml.url do
        xml.loc song_url(song)
        xml.changefreq 'monthly'
        xml.priority 0.5
        xml.lastmod sitemap_date(song)
      end
    end
  end
  cache @venues do
    @venues.each do |venue|
      xml.url do
        xml.loc venue_url(venue)
        xml.changefreq 'monthly'
        xml.priority 0.5
        xml.lastmod sitemap_date(venue)
      end
    end
  end
end
