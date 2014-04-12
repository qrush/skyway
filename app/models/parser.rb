class Parser
  BOOKMARKS = /([#%\*\^\$]+)/

  def self.parse(raw)
    new(raw).parse
  end

  def initialize(raw)
    @raw = raw
    @show = Show.new
    @setlist = nil
    @notes_by_bookmark = {}
    @slots_by_bookmark = {}
    @songs = {}
  end

  def parse
    @raw.split("\n").map(&:strip).each_with_index do |line, index|
      case line
      when /^(SET|ENCORE)/i
        @setlist = @show.setlists.build(position: @show.setlists.size, name: line)
      when /^#{BOOKMARKS}/
        @notes_by_bookmark[$1] = $'.strip
      when /^(.+) >$/
        build_slot($1, transition: true)
      else
        build_slot(line)
      end
    end

    build_notes
    @show
  end

  private

    def build_slot(line, options = {})
      slot = @setlist.slots.build(options.merge(position: @setlist.slots.size))
      name = parse_name(line)

      if song = (@songs[name] || Song.find_by_name(name))
        slot.song = song
      else
        @songs[name] ||= slot.build_song(name: name)
      end

      line.scan(BOOKMARKS).each do |(bookmark)|
        @slots_by_bookmark[bookmark] = slot
      end
    end

    def parse_name(name)
      name.gsub(BOOKMARKS, "").gsub(/(, )?(Part|Pt) [\dI]+/, "").strip
    end

    def build_notes
      @notes_by_bookmark.each do |bookmark, note|
        if @slots_by_bookmark[bookmark]
          @slots_by_bookmark[bookmark].notes << note
        end
      end
    end
end
