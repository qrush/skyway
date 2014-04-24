class Venue < ActiveRecord::Base
  include Showable

  to_param :name
  has_many :shows

  def merge!(other_venue)
    other_venue.shows.each do |show|
      show.venue = self
      show.save!
    end
    other_venue.destroy
  end
end
