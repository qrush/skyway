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
  end

  def parse
    @raw.split("\n").map(&:strip).each_with_index do |line, index|
      case line
      when /^(SET|ENCORE)/i
        @setlist = @show.setlists.build(position: @show.setlists.size)
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

    def build_slot(name, options = {})
      slot = @setlist.slots.build(options.merge(position: @setlist.slots.size))
      song = slot.build_song(name: name.gsub(BOOKMARKS, "").strip)

      name.scan(BOOKMARKS).each do |(bookmark)|
        @slots_by_bookmark[bookmark] = slot
      end
    end

    def build_notes
      @notes_by_bookmark.each do |bookmark, note|
        if @slots_by_bookmark[bookmark]
          @slots_by_bookmark[bookmark].notes << note
        end
      end
    end
end
