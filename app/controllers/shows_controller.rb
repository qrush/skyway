class ShowsController < ApplicationController
  def index
    @shows = Show.order("performed_at desc")
  end
end
