class LyricsController < ApplicationController
  def index
    @albums = Album.order(released_on: :desc)
  end
end
