class Album < ApplicationRecord
  has_many :songs, -> { order(album_position: :asc) }
  has_many :songs_with_lyrics, -> { with_lyrics }, class_name: 'Song'
end
