class Fan < ApplicationRecord
  has_many :identities, dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :shows, through: :attendances
  has_many :songs, through: :shows

  def performed_shows
    @performed_shows ||= shows.performed
  end

  def shows_count
    @shows_count ||= shows.count
  end

  def shows_this_year_count
    @shows_this_year_count ||= shows.where("performed_at > ?", Date.today.beginning_of_year).count
  end

  def songs_count
    @songs_count ||= songs.distinct.count
  end

  def debut_show
    @debut_show ||= shows.ordered.last
  end

  def shows_since_last_show
    @shows_since_last_show ||= Show.before_today.where("performed_at > ?", shows.ordered.first.performed_at).count
  end

  def songs_seen
    songs_by_count = songs.group(:id).order('count_all desc, songs.name asc').count
    songs = Song.find(songs_by_count.keys)
    songs_by_count.map do |id, attended_count|
      songs.find { |song| song.id == id }.tap { |song| song.attended_count = attended_count }
    end
  end

  def to_param
    handle
  end
end
