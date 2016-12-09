class SongsController < ApplicationController
  include Mergeable
  self.mergeable_class = Song
  self.permitted_params = [:name, :cover, :history, :lyrics]

  before_action :require_admin, except: [:index, :show]

  def index
    respond_to do |format|
      format.html do
        @playlist = Playlist.find(params[:order])
        @show_ids = Show.before_today.order(performed_at: :asc).pluck(:id)
      end
      format.csv do
        render csv: Song.with_shows, filename: "songs-#{Date.today}"
      end
    end
  end

  def show
    @song = Song.includes(shows: :venue).find(params[:id])
    @show_ids = Show.before_today.order(performed_at: :asc).pluck(:id)
  end

  def edit
    @song = Song.find(params[:id])
  end

  def destroy
    @song = Song.find(params[:id])

    if @song.destroy
      flash[:success] = "Deleted #{@song.name}."
      redirect_to songs_path
    else
      flash[:error] = "This song must be removed from all shows before deleting."
      redirect_to @song
    end
  end
end
