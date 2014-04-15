module ShowsHelper
  def format_setlist(setlist)
    names = []
    current_jam = []

    setlist.slots.each do |slot|
      notes = ""
      slot.notes.each do |note|
        notes << " #{bookmark(bookmarks[setlist.show_id])}"
        bookmarks[setlist.show_id] += 1
      end

      current_jam << "#{link_to(slot.song.name, slot.song)} #{notes}"

      unless slot.transition?
        names << current_jam.join(" > ")
        current_jam.clear
      end
    end
    names.join(', ').html_safe
  end

  def notes_for(show)
    notes = {}
    index = 0
    show.setlists.map(&:slots).flatten.select(&:notes?).each do |slot|
      slot.notes.each do |note|
        notes[bookmark(index)] = note
        index += 1
      end
    end
    notes
  end

  def bookmark(index)
    %w(* ** *** # % ^ $).fetch(index, "@" * index)
  end

  def bookmarks
    @bookmarks ||= Hash.new(0)
  end
end
