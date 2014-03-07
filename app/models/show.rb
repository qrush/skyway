class Show < ActiveRecord::Base
  belongs_to :venue
  has_many :setlists, -> { order "position asc" }

end
