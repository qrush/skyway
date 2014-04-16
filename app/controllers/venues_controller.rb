class VenuesController < ApplicationController
  def index
    @venues = Venue.order("name asc")
  end

  def show
    @venue = Venue.find(params[:id])
  end
end
