class SongsController < ApplicationController
  def index
    @songs = Song.order("name asc")
  end

  def show
    @song = Song.includes(slots: {setlist: {show: :venue}}).order("shows.performed_at desc").where("lower(songs.name) = ?", CGI.unescape(params[:id]).downcase).first
  end
end
