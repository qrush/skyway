class Slot < ActiveRecord::Base
  belongs_to :setlist
  belongs_to :song

  def show
    setlist.show
  end
end
