class Album < ApplicationRecord
  has_many :songs, -> { order(album_position: :asc).where("lyrics <> ''").with_shows }
end
