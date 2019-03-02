class HomeController < ApplicationController
  def index
    @latest_shows   = Show.latest.limit(7)
    @taped_shows    = Show.taped.limit(2)
    @featured_show  = Show.where(featured: true).first
    @year = DateTime.now.year.to_s
  end

  def show
    benchmark "Contentful Homepage Load" do
      @homepage = Homepage.find_by(title: "home").load.first
    end
    @week_count = 2 || Show.where(["performed_at >= ? and performed_at <= ?", Date.today, Date.today.end_of_week]).count
    @upcoming_shows = Show.upcoming.limit(5)
  end
end
