class ShowsController < ApplicationController
  def index
    @shows = Show.performed
  end

  def show
    @show = Show.find_by_performed_at!(DateTime.parse(params[:id]))
  end
end
