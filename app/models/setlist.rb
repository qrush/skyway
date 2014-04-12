class Setlist < ActiveRecord::Base
  belongs_to :show
  has_many :slots, -> { order "position asc" }
  has_many :songs, through: :slots
end
