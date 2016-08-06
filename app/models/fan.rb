class Fan < ApplicationRecord
  has_many :identities, dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :shows, through: :attendances
  has_many :songs, -> { distinct }, through: :shows

  def shows_count
    @shows_count ||= shows.count
  end

  def shows_this_year_count
    @shows_this_year_count ||= shows.where("performed_at > ?", Date.today.beginning_of_year).count
  end

  def songs_count
    @songs_count ||= songs.count
  end

  def debut_show
    @debut_show ||= shows.ordered.last
  end

  def shows_since_debut
    @shows_since_debut ||= Show.before_today.where("performed_at > ?", debut_show.performed_at).count
  end

  def to_param
    handle
  end
end
