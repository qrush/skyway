class Show < ActiveRecord::Base
  belongs_to :venue
  has_many :sets, -> { order "position asc" }

end
