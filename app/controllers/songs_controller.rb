class SongsController < ApplicationController
  def index
    @songs_by_first_letter = Song.by_name.group_by(&:first_letter)
  end

  def show
    @song = Song.includes(slots: {setlist: {show: :venue}}).order("shows.performed_at desc").find(params[:id])
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    @song.update_attributes!(song_params)
    redirect_to @song
  end

  def merge
    @song = Song.find(params[:id])
    @other_song = Song.find(other_song_params[:other_song_id])

    @song.merge!(@other_song)
    redirect_to @song
  end

  private

    def song_params
      params.require(:song).permit(:name)
    end

    def other_song_params
      params.require(:song).permit(:other_song_id)
    end
end
