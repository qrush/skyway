class SongsController < ApplicationController
  include Mergeable
  self.mergeable_class = Song

  before_filter :require_admin, except: [:index, :show]

  def index
    @songs_by_first_letter = Song.by_name.group_by(&:first_letter)
  end

  def show
    @song = Song.includes(shows: :venue).find(params[:id])
  end

  def edit
    @song = Song.find(params[:id])
  end
end
