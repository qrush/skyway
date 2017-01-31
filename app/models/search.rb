class Search
  include ActiveModel::Model
  attr_accessor :query

  def songs
    @songs ||= if @query
      Song.with_shows.where("name ilike :query or lyrics ilike :query", query: "%#{@query}%").by_name
    else
      []
    end
  end

  def venues
    @venues ||= if @query
      Venue.where("name ilike :query or location ilike :query", query: "%#{@query}%").by_name
    else
      []
    end
  end

  def shows
    @shows ||= Show.performed.find(show_ids)
  end

  def shows_cache_key
    Digest::MD5.hexdigest(shows.pluck(:id, :updated_at).map(&:to_s).join('-'))
  end

  private

    def show_ids
      (songs.map(&:show_ids) + venues.map(&:show_ids) + noted_show_ids + noted_show_ids_from_slots).flatten.uniq
    end

    def noted_show_ids
      Show.from("(select id, unnest(notes) note from shows) shows").
        where("note ilike ?", "%#{@query}%").
        pluck(:id)
    end

    def noted_show_ids_from_slots
      Slot.from("(select setlist_id, unnest(notes) note from slots) slots").
        where("note ilike ?", "%#{@query}%").
        joins(:setlist).
        pluck(:show_id)
    end
end
