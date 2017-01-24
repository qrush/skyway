class AlbumsController < ApplicationController
  before_action :require_admin

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update_attributes(album_params)
    flash[:success] = "Successfully updated this album."
    redirect_to edit_album_path(@album)
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  private

  def album_params
    params.require(:album).permit(:bandcamp_url, :youtube_url)
  end
end
