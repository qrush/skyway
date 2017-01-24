class Album < ApplicationRecord
  has_many :songs, -> { order(album_position: :asc) }
  has_many :songs_with_lyrics, -> { order(album_position: :asc).where("lyrics <> ''") }, class_name: 'Song'
end
