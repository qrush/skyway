class Playlist
  ORDERS = {
    "name"   => "Alphabetical",
    "covers" => "Covers",
    "originals" => "Originals",
    "debuts" => "Debuts",
    "freq"   => "Frequency"
  }

  include ActiveModel::Model
  attr_accessor :order, :page

  def self.playlist_for(order)
    Hash[ORDERS.keys.zip([
      AlphabeticalPlaylist,
      CoverPlaylist,
      OriginalPlaylist,
      DebutPlaylist,
      FrequencyPlaylist
    ])].fetch(order, FrequencyPlaylist)
  end

  def self.find(order, page: 1)
    playlist_class = playlist_for(order)
    playlist_class.new(order: ORDERS.keys.include?(order) ? order : ORDERS.keys.last, page: page)
  end

  def songs
    @songs ||= playlist(Song.with_shows.page(page))
  end

  def cache_key
    Digest::MD5.hexdigest [order, *Song.select(:id, :updated_at).map(&:cache_key)].join("-")
  end

  def template
    nil
  end

  def title
    "All songs"
  end
end

class AlphabeticalPlaylist < Playlist
  def playlist(scope)
    scope.by_name
  end

  def template
    "songs_by_letter"
  end

  def title
    "All songs by name (#{Song.count})"
  end
end

class CoverPlaylist < Playlist
  def playlist(scope)
    scope.where(cover: true).by_name
  end

  def title
    "Covered songs (#{songs.total_count})"
  end
end

class OriginalPlaylist < Playlist
  def playlist(scope)
    scope.where(cover: false).by_name
  end

  def title
    "Original songs (#{songs.total_count})"
  end
end

class DebutPlaylist < Playlist
  def playlist(scope)
    scope.
      select { |song| song.shows.present? }.
      sort_by { |song| song.debut_show.performed_at }.
      reverse
  end

  def title
    "Most recently debuted songs"
  end
end

class FrequencyPlaylist < Playlist
  def playlist(scope)
    scope.order(shows_count: :desc).by_name
  end

  def title
    "Most frequently played songs"
  end
end
