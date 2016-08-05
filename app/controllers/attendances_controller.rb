class AttendancesController < ApplicationController
  before_action :require_current_fan, only: [:create]

  def index
    @shows = Show.latest
    @attended_shows = current_fan.shows.to_a
  end

  def create
    if attendance = @current_fan.attendances.find_by_show_id(params[:show_id])
      attendance.destroy
    else
      @current_fan.attendances.create(show_id: params[:show_id])
    end

    respond_to do |format|
      format.html { redirect_to attendance.show }
      format.js { head :ok }
    end
  end
end
