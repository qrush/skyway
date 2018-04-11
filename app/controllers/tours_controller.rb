class ToursController < ApplicationController
  def show
    @shows_by_venue = Show.upcoming.group_by(&:venue)
  end
end
