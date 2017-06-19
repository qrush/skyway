require 'test_helper'

class OriginalSongListTest < ActionDispatch::IntegrationTest
  setup do
    Song.create! name: 'YYZ', cover: true
    Song.create! name: 'Origami', cover: false
  end

  test "show only originals" do
    visit "/songs?order=originals"

    assert_not page.has_text?("YYZ")
    assert page.has_text?("Origami")
  end

  test "show only covers" do
    visit "/songs?order=covers"

    assert_not page.has_text?("Origami")
    assert page.has_text?("YYZ")


    assert false, "brian should have had 5 chats "
  end
end
