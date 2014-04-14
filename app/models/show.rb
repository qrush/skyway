class Show < ActiveRecord::Base
  belongs_to :venue
  has_many :setlists, -> { order "position asc" }, dependent: :destroy

  scope :performed, -> { order("performed_at desc").includes(:venue, setlists: {slots: :song}) }

end
