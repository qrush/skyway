class Song < ActiveRecord::Base
  include Showable

  has_many :slots
  has_many :setlists, through: :slots
  has_many :shows, -> { merge(Show.ordered).uniq }, through: :setlists

  to_param :name

  scope :with_shows, -> { includes(:shows) }

  before_destroy :check_for_slots

  def version
    cover? ? "cover" : "original"
  end

  def debut_show
    shows.last
  end

  def merge!(other_song)
    other_song.slots.each do |slot|
      slot.song = self
      slot.save!
    end
    other_song.destroy
  end

  private

    def check_for_slots
      slots.empty?
    end
end
