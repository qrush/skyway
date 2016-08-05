class Import < ApplicationRecord
  has_many :imported_shows, dependent: :delete_all
  has_many :imported_venues, dependent: :delete_all

  before_validation :import_shows_and_venues

  validates :imported_shows, presence: true

  def confirm!
    Show.transaction do
      imported_shows.each do |imported_show|
        show_params = imported_show.attributes.except("id", "imported_venue_id", "venue_id", "import_id")
        show_params[:venue] = imported_show.venue ||
          Venue.find_by_name(imported_show.imported_venue.name) ||
          Venue.create!(imported_show.imported_venue.attributes.except("id", "import_id"))

        Show.create!(show_params)
      end

      destroy
    end
  end

  private
    def import_shows_and_venues
      CSV.parse(csv, headers: true, header_converters: :symbol).each do |row|
        performed_at = Chronic.parse(row[:date])
        params = {
          performed_at: performed_at,
          starts_at: Chronic.parse(row[:time], now: performed_at),
          price: row[:admission].try(:gsub, "$", ""),
          url: row[:url],
        }

        if venue = Venue.find_by_name(row[:venue])
          params[:venue] = venue
        elsif imported_venue = ImportedVenue.find_by_name(row[:venue])
          params[:imported_venue] = imported_venue
        else
          params[:imported_venue] = imported_venues.build(
            location: row[:city],
            name: row[:venue],
            address: row[:address]
          )
        end

        imported_shows.build(params)
      end

      # why???
      true
    end
end
