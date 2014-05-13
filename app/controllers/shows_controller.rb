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
    @show = Show.parse(show_params)
    if @show.save
      flash[:success] = "Successfully created a new show."
      redirect_to @show
    else
      render :new
    end
  end

  def update
    @show = find_show_by_performed_at
    @new_show = Show.parse(show_params)
    @new_show.replace(@show)

    flash[:success] = "Successfully updated this show."
    redirect_to @new_show
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  private

    def show_params
      params.require(:show).permit(:performed_at, :raw_setlist, :unknown_setlist, :venue_id, :banner)
    end

    def find_show_by_performed_at
      Show.performed.find_by_performed_at!(DateTime.parse(params[:id]))
    end
end
