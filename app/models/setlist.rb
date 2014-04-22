class Setlist < ActiveRecord::Base
  belongs_to :show
  has_many :slots, -> { order "slots.position asc" }, dependent: :destroy
  has_many :songs, through: :slots

  def cache_key
    [super, *slots.map(&:cache_key)].join("-")
  end

  def to_s
    [name, *slots.map(&:to_s)].join("\n")
  end
end
