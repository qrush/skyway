class AnnouncementsController < ApplicationController
  before_filter :require_admin

  def new
    @announcement = Announcement.new(body: Announcement.last.try(:body))
  end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def announcement_params
      params.require(:announcement).permit(:body)
    end
end
