class Setlist < ActiveRecord::Base
  belongs_to :show
  has_many :slots, -> { order "position asc" }, dependent: :destroy
  has_many :songs, through: :slots
end
