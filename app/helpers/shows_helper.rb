module ShowsHelper
  def format_setlist(show, setlist)
    names = []
    current_jam = []

    setlist.slots.each do |slot|
      notes = ""
      slot.notes.each do |note|
        notes << "<sup>#{bookmark(show.notes.index(note))}</sup> "
      end

      current_jam << "#{link_to(slot.song.name, slot.song)}#{notes.strip}"

      unless slot.transition?
        names << current_jam.join(" > ")
        current_jam.clear
      end
    end
    names.join(', ').html_safe
  end

  def bookmark(index)
    %w(* ** *** # % ^ $).fetch(index, "@" * index)
  end
end
