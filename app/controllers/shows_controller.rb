class ShowsController < ApplicationController
  def index
    @shows = Show.performed
  end
end
