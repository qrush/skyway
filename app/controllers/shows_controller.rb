class ShowsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    @year = params[:year] || DateTime.now.year.to_s
    @shows = Show.performed.for_year(@year)
  end

  def show
    @show = Show.performed.find_by_performed_at!(DateTime.parse(params[:id]))
  end

  def new
    @show = Show.new
  end

  def create
    @show = Parser.parse(show_params)
    @show.save!
    redirect_to @show
  end

  private

    def show_params
      params.require(:show).permit(:performed_at, :raw_setlist, :venue_id)
    end
end
