class VenuesController < ApplicationController
  include Mergeable
  self.mergeable_class = Venue

  def index
    @venues_by_first_letter = Venue.by_name.group_by(&:first_letter)
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def edit
    @venue = Venue.find(params[:id])
  end
end
