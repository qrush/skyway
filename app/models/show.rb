class Show < ActiveRecord::Base
  belongs_to :venue
  has_many :setlists, -> { order "setlists.position asc" }, dependent: :destroy

  scope :performed, -> { order("performed_at desc").includes(:venue, setlists: {slots: :song}) }

  attr_accessor :bookmark_index, :raw_setlist

  def notes?
    slots.any?(&:notes?)
  end

  def notes
    @notes ||= cache_notes
  end

  def when
    performed_at.to_date.to_s(:long_ordinal)
  end

  def to_param
    performed_at.to_date.to_s(:db)
  end

  def cache_key
    "#{super}-#{Digest::MD5.hexdigest [ venue.cache_key, *setlists.map(&:cache_key) ].join("-")}"
  end

  private

    def slots
      setlists.map(&:slots).flatten
    end

    def cache_notes
      notes = []
      slots.select(&:notes?).each do |slot|
        slot.notes.each do |note|
          notes << note
        end
      end
      notes.uniq
    end
end
