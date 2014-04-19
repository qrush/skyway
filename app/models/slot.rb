class Slot < ActiveRecord::Base
  belongs_to :setlist
  belongs_to :song

  def cache_key
    "#{super}-#{song.cache_key}"
  end

  def show
    setlist.show
  end
end
