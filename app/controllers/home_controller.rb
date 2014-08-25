class HomeController < ApplicationController
  def index
    @upcoming_shows = Show.upcoming.limit(10)
    @latest_shows   = Show.latest.limit(5)
    @taped_shows    = Show.taped.limit(3)
  end

  def show
    @upcoming_shows = Show.upcoming.limit(5)
    render "show", layout: "new"
  end
end
