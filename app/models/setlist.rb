class Setlist < ActiveRecord::Base
  belongs_to :show
  has_many :slots, -> { order "slots.position asc" }, dependent: :destroy
  has_many :songs, through: :slots

  def cache_key
    [super, *slots.map(&:cache_key)].join("-")
  end
end
