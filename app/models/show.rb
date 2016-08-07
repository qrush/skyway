class Show < ApplicationRecord
  HUMAN_BOOKMARKS = %w(* ** *** # ## ### % %% %%% ^ ^^ ^^^ $ $$ $$$)
  FANCY_BOOKMARKS = %w(1 2 3 4 5 6 7 8 9)

  belongs_to :venue
  has_many :setlists, -> { order position: :asc }, dependent: :destroy
  has_many :unordered_setlists, class_name: 'Setlist'
  has_many :songs, through: :unordered_setlists
  has_many :attendances
  has_many :fans, through: :attendances

  has_attached_file :banner,
    styles: {fit: "1056x200#"},
    convert_options: {fit: "-strip"}

  validates_presence_of :performed_at, :venue
  validates_attachment :banner, content_type: { content_type: /\Aimage\/.*\Z/ }

  scope :upcoming,     -> { where("date(performed_at) >= ?", Skyway.time_zone.now.beginning_of_day).order(performed_at: :asc) }
  scope :latest,       -> { before_today.performed }
  scope :taped,        -> { where.not(embeds: "").ordered }
  scope :before_today, -> { where("date(performed_at) <= ?", Skyway.time_zone.now.beginning_of_day) }
  scope :ordered,      -> { order(performed_at: :desc) }
  scope :performed,    -> { ordered.includes(:venue, setlists: {slots: :song}) }
  scope :for_year,     -> (year) { before_today.where("EXTRACT(YEAR FROM performed_at) = ?", year) }

  attr_writer :raw_setlist

  def self.parse(params)
    Parser.parse(params).tap(&:save)
  end

  def replace(show)
    transaction do
      self.banner = show.banner if !self.banner? && show.banner?
      self.venue = show.venue
      self.performed_at = show.performed_at
      self.attendances += show.attendances
      save!
      show.destroy
    end
  end

  def notes?
    notes.any?
  end

  def notes
    @notes ||= cache_notes
  end

  def name
    "#{venue.location} @ #{venue.name}"
  end

  def when
    performed_at.to_date.to_s(:long_ordinal)
  end

  def short_when
    performed_at.strftime("%m/%e/%Y").gsub(/(^0|\s)/, "")
  end

  def played?
    performed_at <= Date.today.end_of_day
  end

  def to_param
    performed_at.to_date.to_s(:db)
  end

  def cache_key
    "#{super}-#{Digest::MD5.hexdigest [ venue.cache_key, *setlists.map(&:cache_key) ].join("-")}"
  end

  def simple_setlist
    setlists.map { |setlist| setlist.to_s(without_notes: true) }.join(" \n")
  end

  def raw_setlist
    @raw_setlist || [*setlists.map(&:to_s), *note_setlist].join("\n\n")
  end

  def bookmark_for(note, bookmarks = FANCY_BOOKMARKS)
    index = notes.index(note)
    bookmarks[index] || "@" * (index - 7)
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
        ["NOTES", *notes.map { |note| "#{bookmark_for(note, HUMAN_BOOKMARKS)} #{note}" }].join("\n")
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
