class Slot < ActiveRecord::Base
  belongs_to :setlist
  belongs_to :song, touch: true

  def cache_key
    "#{super}-#{song.cache_key}"
  end

  def show
    setlist.show
  end

  def to_s(options = {})
    name = [song.name]
    notes.each do |note|
      name << show.bookmark_for(note, Show::HUMAN_BOOKMARKS)
    end unless options[:without_notes]
    name << ">" if transition?
    name.join(" ")
  end
end
