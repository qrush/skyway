class Venue < ActiveRecord::Base
  include Showable

  to_param :name
  has_many :shows

  geocoded_by :geocode_location
  before_save :geocode

  def geocode_location
    [location, address].compact.join(', ')
  end

  TILE_ZOOM = 11

  def to_tile
    if latitude? && longitude?
      [TILE_ZOOM, *SimpleMercatorLocation.new(lat: latitude, lon: longitude).zoom_at(TILE_ZOOM).to_tile].join("/")
    else
      ""
    end
  end

  def merge!(other_venue)
    other_venue.shows.each do |show|
      show.venue = self
      show.save!
    end
    other_venue.destroy
  end
end
