class HomeController < ApplicationController
  def index
    @latest_shows   = Show.latest.limit(7)
    @taped_shows    = Show.taped.limit(3)
  end

  def show
    @upcoming_shows = Show.upcoming.limit(5)
    @announcement = Announcement.last
  end
end
