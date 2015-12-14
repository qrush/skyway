class Venue < ActiveRecord::Base
  include Showable

  to_param :name
  has_many :shows

  geocoded_by :geocode_location
  before_save :geocode

  def geocode_location
    [location, address].compact.join(', ')
  end

  TILE_ZOOM = 10

  def to_tile(x_modifier = 0)
    if latitude? && longitude?
      x, y = SimpleMercatorLocation.new(lat: latitude, lon: longitude).zoom_at(TILE_ZOOM).to_tile
      [TILE_ZOOM, x + x_modifier, y].join("/")
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
