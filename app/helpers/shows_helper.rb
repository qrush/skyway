module ShowsHelper
  def format_setlist(show, setlist)
    names = []
    current_jam = []

    setlist.slots.each do |slot|
      notes = ""
      slot.notes.each do |note|
        notes << "<sup>#{show.bookmark_for(note)}</sup> "
      end

      current_jam << "#{link_to(slot.song.name, slot.song)}#{notes.strip}"

      unless slot.transition?
        names << current_jam.join(" > ")
        current_jam.clear
      end
    end
    names.join(', ').html_safe
  end

  def year_buttons_for(current_year)
    (2006..DateTime.now.year).map do |year|
      options ||= {}
      options[:class] = "active" if year.to_s == current_year
      link_to year, shows_path(year: year), options
    end.join.html_safe
  end
end
