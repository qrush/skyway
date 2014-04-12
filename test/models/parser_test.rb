require 'test_helper'

class ParserTest < ActiveSupport::TestCase
  setup do
    @show = Parser.parse <<EOF
SET I
Kitty Chaser (Explosions)
What's the Connection?
Village Dog and Pony Show >
Warren in the Window >
Bloody Well Right *
Eon Don ** >
They're Calling For Ya >
Triangle
SET II
King For A Day
Staring into the Sun
All In
Complex Part I >
Origami
Complex Part II >
Obla Di Obla Da ***
The Median
They're Calling For Ya >
Triangle
ENCORE
Mosquito Valley Part I >
Strange Times
* Supertramp cover
** "Purple Haze" and "Third Stone from the Sun" (Jimi Hendrix) teases
*** The Beatles cover
EOF
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
    assert_equal ['Mosquito Valley Part I >', 'Strange Times'], @show.setlists.last.songs.map(&:name)
  end

  test "show can be saved" do
    @show.save!
  end
end
