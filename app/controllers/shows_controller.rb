class ShowsController < ApplicationController
  def index
    @shows = Show.order("performed_at desc").includes(:venue, setlists: {slots: :song})
  end
end
