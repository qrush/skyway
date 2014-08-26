module ApplicationHelper
  def nav_menu
    links = [
      link_to("Home",     root_path),
      link_to("Tour",     tour_path),
      link_to("Setlists", shows_path),
      link_to("Music",    page_path("music")),
      link_to("Merch",    page_path("merch")),
      link_to("About",    page_path("about")),
      link_to("Contact",  page_path("contact"))
    ]
    links.map { |link| content_tag :li, link, class: "nav-link" }.join.html_safe
  end
end
