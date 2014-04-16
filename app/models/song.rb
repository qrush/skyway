class Song < ActiveRecord::Base
  has_many :slots
  has_many :setlists, through: :slots

  def to_param
    CGI.escape(name).downcase
  end
end
