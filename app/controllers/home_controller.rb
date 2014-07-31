class HomeController < ApplicationController
  def index
    @shows = Show.performed.where("performed_at < ?", Date.today.end_of_day).limit(5)
  end
end
