class ImportedVenue < ActiveRecord::Base
  belongs_to :import

  has_many :imported_shows

  validates :name, presence: true
  validates :location, presence: true
end
