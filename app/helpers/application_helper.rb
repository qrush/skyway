module ApplicationHelper
  def nav_menu
    links = [
      link_to("Home", root_path),
      link_to("Tour", tour_path),
      link_to("Setlists", shows_path),
      link_to("Music", "#"),
      link_to("Merch", "#"),
      link_to("About", "#"),
      link_to("Contact", "#")
    ]
    links.map { |link| content_tag :li, link, class: "nav-link" }.join.html_safe
  end
end
