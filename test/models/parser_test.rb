require 'test_helper'

class BasicParserTest < ActiveSupport::TestCase
  setup do
    @show = Parser.parse raw_setlists("kitty")
  end

  test "has 3 sets" do
    assert_equal 3, @show.setlists.size
    assert_equal [0, 1, 2], @show.setlists.map(&:position)
  end

  test "slots are parsed out of sets" do
    assert_equal 8,  @show.setlists.first.slots.size
    assert_equal 10, @show.setlists.second.slots.size
    assert_equal 2,  @show.setlists.third.slots.size
  end

  test "songs are parsed out of sets" do
    slots = @show.setlists.last.slots
    assert_equal ['Mosquito Valley', 'Strange Times'], slots.map { |slot| slot.song.name }
  end

  test "transitions are marked" do
    slot = @show.setlists.last.slots.first
    assert_equal 'Mosquito Valley', slot.song.name
    assert slot.transition?
  end

  test "notes are remembered" do
    slot1 = @show.setlists.first.slots[4]
    slot2 = @show.setlists.first.slots[5]
    slot3 = @show.setlists.second.slots[6]

    assert_equal [%{Supertramp cover}], slot1.notes
    assert_equal [%{"Purple Haze" and "Third Stone from the Sun" (Jimi Hendrix) teases}], slot2.notes
    assert_equal [%{The Beatles cover}], slot3.notes
  end

  test "show can be saved" do
    @show.save!
  end
end

class EdgeParserTest < ActiveSupport::TestCase
  test "more than one note is supported" do
    show = Parser.parse raw_setlists("candy")
    slot = show.setlists.first.slots.first

    assert_equal ["Mahnkali's Pocket Watch tease", "With John from Broccoli Samurai on guitar"], slot.notes
  end

  test "parts of songs are parsed" do
    show = Parser.parse raw_setlists("origami")
    show.save!

    slot1 = show.setlists.first.slots.first
    slot2 = show.setlists.last.slots.first

    assert_equal "Yoshimi Battles the Pink Robots", slot1.song.name
    assert_equal slot1.song_id, slot2.song_id
  end

  test "songs aren't repeated" do
    assert_nothing_raised do
      2.times do
        show = Parser.parse raw_setlists("origami")
        show.save!
      end
    end
  end
end