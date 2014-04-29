module ShowsHelper
  def format_setlist(show, setlist)
    names = []
    current_jam = []

    cover_options = {class: "cover", title: "Cover song"}

    setlist.slots.each do |slot|
      notes = ""
      slot.notes.each do |note|
        notes << "<sup>#{show.bookmark_for(note)}</sup> "
      end

      song_link = link_to(slot.song.name, slot.song, slot.song.cover? ? cover_options : {})
      current_jam << "#{song_link}#{notes.strip}"

      unless slot.transition?
        names << "<em>#{current_jam.join(" > ")}</em>"
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
