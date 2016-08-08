class Song < ApplicationRecord
  include Showable

  has_many :slots
  has_many :setlists, through: :slots
  has_many :shows, -> { distinct.merge(Show.ordered) }, through: :setlists

  attr_accessor :attended_count

  to_param :name

  scope :with_shows, -> { includes(:shows) }

  before_destroy :check_for_slots
  after_touch :update_shows_count

  def version
    cover? ? "cover" : "original"
  end

  def debut_show
    shows.last
  end

  def shows_since_debut
    Show.before_today.where("performed_at > ?", debut_show.performed_at).count
  end

  def shows_since_last_play
    Show.before_today.where("performed_at > ?", shows.first.performed_at).count
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

    def update_shows_count
      Song.where(id: id).update_all shows_count: shows.count
    end
end
