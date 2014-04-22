class ShowsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    @year = params[:year] || DateTime.now.year.to_s
    @shows = Show.performed.for_year(@year)
  end

  def show
    @show = find_show_by_performed_at
  end

  def new
    @show = Show.new
  end

  def edit
    @show = find_show_by_performed_at
  end

  def create
    @show = Show.parse!(show_params)
    redirect_to @show
  end

  def update
    old_show = find_show_by_performed_at
    new_show = old_show.replace!(show_params)
    redirect_to new_show
  end

  private

    def show_params
      params.require(:show).permit(:performed_at, :raw_setlist, :venue_id)
    end

    def find_show_by_performed_at
      Show.performed.find_by_performed_at!(DateTime.parse(params[:id]))
    end
end
