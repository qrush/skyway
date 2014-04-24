class Song < ActiveRecord::Base
  include Showable

  has_many :slots
  has_many :setlists, through: :slots
  has_many :shows, -> { uniq }, through: :setlists

  to_param :name

  def debut_show
    performed_shows.last
  end

  def performed_shows
    @performed_shows ||= shows.performed
  end

  def merge!(other_song)
    other_song.slots.each do |slot|
      slot.song = self
      slot.save!
    end
    other_song.destroy
  end
end
