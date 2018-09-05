module ApplicationHelper
  def nav_menu
    links = [
      link_to("Home",     "/home"),
      link_to("Tour",     tour_path),
      link_to("Music",    page_path("music")),
      link_to("Lyrics",   lyrics_path),
      link_to("Merch",    "https://aqueousband.hilinemerchandising.com/"),
      link_to("Setlists", setlists_path),
      link_to("Mobilize", "https://www.signupgenius.com/go/60b0449aaaa2da0fe3-aqueous"),
      link_to("About",    page_path("about")),
      link_to("Contact",  page_path("contact"))
    ]
    links.map { |link| content_tag :li, link, class: "nav-link" }.join.html_safe
  end

  def raw_format(text)
    simple_format text, {}, {sanitize: false}
  end

  def link_to_file_url(text, path, *options)
    link_to text, file_url(path), *options
  end

  def file_url(path)
    "https://s3.amazonaws.com/files.aqueousband.net/images/#{path}"
  end

  def sitemap_date(record)
    record.updated_at.strftime '%Y-%m-%d'
  end

  def copy_for(title)
    benchmark "Contentful Load: #{title}" do
      if copy = Copy.find_by(title: title).load&.first
        render_markdown(copy.blurb)
      end
    end
  end

  def render_markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    renderer.render(text).html_safe
  end

  def musicpage
    @musicpage ||= benchmark "Contentful Musicpage Load" do
      Musicpage.find("7FVrQGAm76AMIqwkqQaICg")
    end
  end

  def colorwheel
    @colorwheel ||= benchmark "Contentful Colorwheel Load" do
      Colorwheel.find("1Hyj0hxDY8CeIcEmKOWWCG")
    end
  end
end
