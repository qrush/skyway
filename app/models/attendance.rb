class Attendance < ApplicationRecord
  belongs_to :fan
  belongs_to :show

  validates :show, uniqueness: { scope: :fan }
end
