class SetlistsController < ApplicationController
  before_action :require_admin

  def edit
    @show = find_show_by_performed_at
  end

  def update
    @show = find_show_by_performed_at
    @new_show = Show.parse(show_params)
    @new_show.replace(@show)

    flash[:success] = "Successfully updated this show's setlist."
    redirect_to @new_show
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  private

    def show_params
      params.require(:show).permit(:raw_setlist, :unknown_setlist, :extra_notes, :embeds, :featured)
    end

    def find_show_by_performed_at
      Show.performed.find_by_performed_at!(DateTime.parse(params[:show_id]))
    end
end
