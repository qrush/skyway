class Parser
  def self.parse(raw)
    new(raw).parse
  end

  def initialize(raw)
    @raw = raw
    @show = Show.new
  end

  def parse
    @raw.split("\n").each_with_index do |line, index|
      case line
      when /^(SET|ENCORE)/i
        setlist = @show.setlists.build(position: @show.setlists.size)
      end
    end

    @show
  end
end
