class SongsController < ApplicationController
  def index
    @songs_by_first_letter = Song.order("name asc").group_by(&:first_letter)
  end

  def show
    @song = Song.includes(slots: {setlist: {show: :venue}}).order("shows.performed_at desc").find(params[:id])
  end
end
