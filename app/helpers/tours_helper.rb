module ToursHelper
  def link_to_address_for(venue)
    query = [venue.address, venue.location].compact.join(" ")

    link_to venue.address || venue.location, "http://maps.google.com?q=#{CGI.escape(query)}"
  end

  def link_to_price_for(show)
    if show.url.present?
      link_to "Tickets (#{price_for(show)})", show.url
    else
      price_for(show)
    end
  end

  def price_for(show)
    if (price = show.price.to_f) == 0
      "Free"
    else
      number_to_currency(price, precision: (price.round == price) ? 0 : 2)
    end
  end

  def starts_at_for(show)
    show.starts_at ? show.starts_at.strftime("%I:%M %p").gsub(/^0/, "") : "TBA"
  end

  def performed_at_for(show)
    show.performed_at.strftime("%m/%d/%y")
  end
end
