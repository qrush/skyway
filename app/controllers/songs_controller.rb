class SongsController < ApplicationController
  include Mergeable
  self.mergeable_class = Song
  self.permitted_params = [:name, :cover, :history, :lyrics]

  before_filter :require_admin, except: [:index, :show]

  def index
    @playlist = Playlist.find(params[:order])
    @show_ids = Show.before_today.order(performed_at: :asc).pluck(:id)
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
