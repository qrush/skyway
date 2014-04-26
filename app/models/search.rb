class Search
  include ActiveModel::Model
  attr_accessor :query

  def songs
    @songs ||= if @query
      Song.where("lower(name) like lower(?)", "%#{@query}%").by_name
    else
      []
    end
  end

  def venues
    @venues ||= if @query
      Venue.where("lower(name) like lower(:query) or lower(location) like lower(:query)", query: "%#{@query}%").by_name
    else
      []
    end
  end

  def shows
    @shows ||= Show.performed.find(show_ids)
  end

  private

    def show_ids
      (songs.map(&:show_ids).flatten + venues.map(&:show_ids).flatten).uniq
    end
end
