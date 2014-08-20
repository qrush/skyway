class ToursController < ApplicationController
  def show
    @shows = Show.upcoming
  end
end
