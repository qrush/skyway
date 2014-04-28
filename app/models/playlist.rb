class Playlist
  ORDERS = {
    "name"   => "Alphabetical",
    "covers" => "Covers",
    "debuts" => "Debuts",
    "freq"   => "Frequency"
  }

  include ActiveModel::Model
  attr_accessor :order

  def self.playlist_for(order)
    Hash[ORDERS.keys.zip([
      AlphabeticalPlaylist,
      CoverPlaylist,
      DebutPlaylist,
      FrequencyPlaylist
    ])].fetch(order, FrequencyPlaylist)
  end

  def self.find(order)
    playlist_class = playlist_for(order)
    playlist_class.new(order: ORDERS.keys.include?(order) ? order : ORDERS.keys.last)
  end

  def songs
    @songs ||= playlist(Song.with_shows)
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
    "Covered songs (#{songs.count})"
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
    scope.
      select("songs.*, count(song_id) as songs_count").
      joins(:slots).
      group("songs.id").
      order("songs_count desc")
  end

  def title
    "Most frequently played songs"
  end
end
