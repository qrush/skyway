class LyricsController < ApplicationController
  def index
    @albums = Album.order(released_on: :desc).includes(:songs_with_lyrics)
  end
end
