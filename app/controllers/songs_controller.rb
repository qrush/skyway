class SongsController < ApplicationController
  def index
    @songs = Song.order("name asc")
  end

  def show
    @song = Song.includes(setlists: :show).order("shows.performed_at desc").find(params[:id])
  end
end
