class Parser
  def self.parse(raw)
    new(raw).parse
  end

  def initialize(raw)
    @raw     = raw.strip
    @show    = Show.new
    @setlist = nil
  end

  def parse
    @raw.split("\n").map(&:strip).each_with_index do |line, index|
      case line
      when /^(SET|ENCORE)/i
        @setlist = @show.setlists.build(position: @show.setlists.size)
      when /^\*/
        # ignore notes for now
      when /^(.+) >$/
        build_slot($1, transition: true)
      else
        build_slot(line)
      end
    end

    @show
  end

  private

    def build_slot(line, options = {})
      slot = @setlist.slots.build(options.merge(position: @setlist.slots.size))
      slot.build_song(name: line)
    end
end
