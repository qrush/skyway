class LyricsController < ApplicationController
  def index
    other_album = Album.new(name: 'Everything else')
    other_album.songs_with_lyrics = Song.with_lyrics.where(album_id: nil)
    @albums = Album.order(released_on: :desc).includes(:songs_with_lyrics) + [other_album]
  end
end
