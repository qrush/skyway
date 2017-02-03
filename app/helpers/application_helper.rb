module ApplicationHelper
  def nav_menu
    links = [
      link_to("Home",     "/home"),
      link_to("Tour",     tour_path),
      link_to("Music",    page_path("music")),
      link_to("Lyrics",   lyrics_path),
      link_to("Merch",    "http://aqueous1.bandcamp.com/merch", target: "_blank"),
      link_to("Setlists", setlists_path),
      link_to("Mobilize", page_path("mobilize")),
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
end
