class ShowsController < ApplicationController
  def index
    @shows = Show.order("performed_at desc").includes(:venue, setlists: {slots: :song}).limit(5)
  end
end
