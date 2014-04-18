class Venue < ActiveRecord::Base
  include Showable

  has_many :shows

  def merge!(other_venue)
    other_venue.shows.each do |show|
      show.venue = self
      show.save!
    end
    other_venue.destroy
  end
end
