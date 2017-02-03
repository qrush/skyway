class SitemapController < ApplicationController
  def index
    @pages = %w(
      about
      bestinshow
      contact
      lyrics
      mobilize
      music
      sampler
      setlists
      taping
      tour
    )
    @shows = Show.ordered
    @songs = Song.order(name: :asc)
    @venues = Venue.order(name: :asc)
    respond_to do |format|
      format.xml
    end
  end
end
