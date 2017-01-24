class LyricsController < ApplicationController
  def index
    @songs = Song.with_shows.with_lyrics
  end
end
