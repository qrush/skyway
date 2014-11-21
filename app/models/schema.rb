class Schema
  include ActiveModel::Serializers::JSON

  def as_json(*)
    {
      :@context => "http://schema.org",
      :@type => "MusicGroup",
      :name => "Aqueous",
      :description => "Groovy rock band that uses gratifying harmonies and multiple soundscapes to build an intense bond with the crowd through an improvisational foundation.",
      :image => [
        "http://files.aqueousband.net/images/2014/AQ-PRESSPIC.jpg",
        "http://files.aqueousband.net/images/2014/nightlights-2.jpg"
      ]
    }
  end
end
