class Parser
  def self.parse(raw)
    new(raw).parse
  end

  def initialize(raw)
    @raw = raw.strip
    @show = Show.new
  end

  def parse
    setlist = nil
    @raw.split("\n").map(&:strip).each_with_index do |line, index|
      case line
      when /^(SET|ENCORE)/i
        setlist = @show.setlists.build(position: @show.setlists.size)
      when /^\*/
        # ignore notes for now
      else
        song = setlist.songs.find_or_initialize_by(name: line)
        setlist.slots.build(song: song, position: setlist.slots.size)
      end
    end

    @show
  end
end
