class Song < ActiveRecord::Base
  has_many :slots
  has_many :setlists, through: :slots
  has_many :shows, through: :setlists

  scope :by_name, -> { order("name asc") }

  validates_presence_of :name

  def other_song_id
    id
  end

  def debut_slot
    slots.last
  end

  def shows_percentage
    (shows.count / Show.count.to_f) * 100
  end

  def first_letter
    if name =~ /^[A-Z]/i
      name[0]
    else
      "#"
    end
  end

  def to_param
    "#{id}-#{CGI.escape(name).downcase}"
  end

  def merge!(other_song)
    other_song.slots.each do |slot|
      slot.song = self
      slot.save!
    end
    other_song.destroy
  end
end
