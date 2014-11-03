class Schema
  include ActiveModel::Serializers::JSON

  class Event
    include Rails.application.routes.url_helpers

    def initialize(show)
      @show = show
    end

    def as_json(*)
      {
        :@type => "Event",
        :location => @show.venue.location,
        :startDate => @show.performed_at.to_date,
        :url => @show.url.presence || "http://aqueousband.com/shows/#{@show.to_param}"
      }
    end
  end

  def events
    Show.upcoming.limit(5).map { |show| Event.new(show) }
  end

  def as_json(*)
    {
      :@context => "http://schema.org",
      :@type => "MusicGroup",
      :name => "Aqueous",
      :description => "Groovy rock band that uses gratifying harmonies and multiple soundscapes to build an intense bond with the crowd through an improvisational foundation.",
      :image => [
        "http://files.aqueousband.net/images/2014/AQ-PRESSPIC.jpg",
        "http://files.aqueousband.net/images/2014/nightlights-2.jpg"
      ],
      :event => events,
      :video => {
        :@type => "VideoObject",
        :description => "Debut track from the latest Aqueous album Cycles, released on 10/21/14",
        :name => "Aqueous - '20/20' - Cycles",
        :url => "https://www.youtube.com/watch?v=8kUapstQu_4"
      }
    }
  end
end
