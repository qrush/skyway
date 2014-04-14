module ShowsHelper
  def format_setlist(setlist)
    names = []
    current_name = []
    setlist.slots.each do |slot|
      current_name << slot.song.name
      unless slot.transition?
        names << current_name.join(" > ")
        current_name.clear
      end
    end
    names.join(', ')
  end
end
