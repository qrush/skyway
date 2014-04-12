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
        slot = setlist.slots.build(position: setlist.slots.size)
        slot.build_song(name: line)
      end
    end

    @show
  end
end
