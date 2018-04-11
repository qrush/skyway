require 'test_helper'

class ToursHelperTest < ActionView::TestCase
  setup do
    @show = Show.new
  end

  test "show starts TBA by default" do
    assert_equal "TBA", starts_at_for(@show)
  end

  test "show starts is formatted simply" do
    @show.starts_at = Time.parse("09:00 PM")
    assert_equal "9:00 PM", starts_at_for(@show)
  end

  test "show starts keeps leading numbers" do
    @show.starts_at = Time.parse("11:00 PM")
    assert_equal "11:00 PM", starts_at_for(@show)
  end

  test "performed at for shortens date" do
    @show.performed_at = Date.parse("August 19th 2014")
    assert_equal "08/19/14", performed_at_for(@show)
  end
end
