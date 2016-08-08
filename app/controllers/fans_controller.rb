class FansController < ApplicationController
  def show
    @fan = Fan.find_by_handle(params[:id])
    @show_ids = Show.before_today.order(performed_at: :asc).pluck(:id)
  end
end
