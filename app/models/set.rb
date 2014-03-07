class Set < ActiveRecord::Base
  belongs_to :show
  has_many :slots, -> { order "position asc" }
end
