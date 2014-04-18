class Search
  attr_reader :query

  def initialize(query)
    @query = query
  end

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
end
