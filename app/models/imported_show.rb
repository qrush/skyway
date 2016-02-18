class ImportedShow < ActiveRecord::Base
  belongs_to :import

  belongs_to :venue
  belongs_to :imported_venue

  validates :performed_at, presence: true

  def venue_for
    venue || imported_venue
  end
end
