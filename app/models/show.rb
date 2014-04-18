class Show < ActiveRecord::Base
  belongs_to :venue
  has_many :setlists, -> { order "position asc" }, dependent: :destroy

  scope :performed, -> { order("performed_at desc").includes(:venue, setlists: {slots: :song}) }

  attr_accessor :bookmark_index, :raw_setlist

  def notes?
    setlists.map(&:slots).flatten.any?(&:notes?)
  end

  def when
    performed_at.to_date.to_s(:long_ordinal)
  end

  def to_param
    performed_at.to_date.to_s(:db)
  end
end
