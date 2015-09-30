class HomeController < ApplicationController
  def index
    @latest_shows   = Show.latest.limit(7)
    @taped_shows    = Show.taped.limit(2)
    @featured_show  = Show.where(featured: true).first
  end

  def show
    @upcoming_shows = Show.upcoming.limit(5)
    @announcement = Announcement.last || Announcement.new
    @week_count = Show.where(["performed_at >= ? and performed_at <= ?", Date.today, Date.today.end_of_week]).count
  end
end
