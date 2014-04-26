class Show < ActiveRecord::Base
  belongs_to :venue
  has_many :setlists, -> { order position: :asc }, dependent: :destroy

  validates_presence_of :performed_at, :venue
  validates_presence_of :setlists, unless: :unknown_setlist?
  validates_uniqueness_of :performed_at

  scope :ordered, -> { order(performed_at: :desc) }
  scope :performed, -> { ordered.includes(:venue, setlists: {slots: :song}) }
  scope :for_year, -> (year) { where("EXTRACT(YEAR FROM performed_at) = ?", year) }

  attr_writer :raw_setlist

  def self.parse(params)
    Parser.parse(params).tap(&:save)
  end

  def replace(show)
    transaction do
      show.destroy
      save!
    end
  end

  def notes?
    notes.any?
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

  def raw_setlist
    @raw_setlist || [*setlists.map(&:to_s), *note_setlist].join("\n\n")
  end

  def bookmark_for(note)
    index = notes.index(note)
    %w(* ** *** # % ^ $).fetch(index, "@" * index)
  end

  def next_show
    @next_show ||= self.class.ordered.where("performed_at > ?", performed_at).last
  end

  def previous_show
    @previous_show ||= self.class.ordered.where("performed_at < ?", performed_at).first
  end

  private

    def slots
      setlists.map(&:slots).flatten
    end

    def note_setlist
      if notes?
        ["NOTES", *notes.map { |note| "#{bookmark_for(note)} #{note}" }].join("\n")
      end
    end

    def cache_notes
      notes = []
      slots.select(&:notes?).each do |slot|
        slot.notes.each do |note|
          notes << note
        end
      end
      notes.uniq + self[:notes]
    end
end
