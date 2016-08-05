class VenuesController < ApplicationController
  include Mergeable
  self.mergeable_class = Venue
  self.permitted_params = [:name, :location, :address, :url, :twitter, :facebook]

  before_action :require_admin, except: [:index, :show]

  def index
    @venues_by_first_letter = Venue.by_name.group_by(&:first_letter)
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(mergeable_params)
    @venue.save!
    redirect_to @venue
  end
end
