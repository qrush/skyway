class Song < ActiveRecord::Base
  include Showable

  has_many :slots
  has_many :setlists, through: :slots
  has_many :shows, -> { performed }, through: :setlists

  def debut_slot
    slots.last
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
