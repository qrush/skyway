class Album < ApplicationRecord
  has_many :songs, -> { order(album_position: :asc).with_shows }
end
