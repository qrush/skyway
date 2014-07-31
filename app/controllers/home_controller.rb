class HomeController < ApplicationController
  def index
    @upcoming_shows = Show.performed.where("performed_at > ?", Date.today.end_of_day)
    @latest_shows   = Show.performed.where("performed_at < ?", Date.today.end_of_day).limit(5)
    @taped_shows    = Show.performed.where.not(embeds: "").limit(3)
  end
end
