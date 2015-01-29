class ShowsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    @year = params[:year] || DateTime.now.year.to_s
    @shows = Show.latest.for_year(@year)
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
    @show = Show.new(show_params)
    if @show.save
      flash[:success] = "Successfully created a new show."
      redirect_to @show
    else
      render :new
    end
  end

  def update
    @show = find_show_by_performed_at
    @show.update_attributes(show_params)
    flash[:success] = "Successfully updated this show."
    redirect_to @show
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @show = find_show_by_performed_at
    @show.destroy

    flash[:success] = "Successfully removed the show for #{@show.when}."
    redirect_to shows_path
  end

  private

    def show_params
      params.require(:show).permit(:performed_at, :venue_id, :banner, :unknown_setlist, :url, :price, :age_restriction, :starts_at, :featured)
    end

    def find_show_by_performed_at
      Show.performed.find_by_performed_at!(DateTime.parse(params[:id]))
    end
end
