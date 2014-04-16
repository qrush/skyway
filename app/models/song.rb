class Song < ActiveRecord::Base
  has_many :slots
  has_many :setlists, through: :slots

  validates_presence_of :name

  def to_param
    "#{id}-#{CGI.escape(name).downcase}"
  end

  def merge(other_song)
    other_song.slots.each do |slot|
      slot.song = self
      slot.save!
    end
    other_song.destroy
  end
end
