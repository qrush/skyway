class HomeController < ApplicationController
  def index
    @shows = Show.performed.limit(5)
  end
end
