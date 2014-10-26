require 'test_helper'

class RedirectionTest < ActionDispatch::IntegrationTest
  test "static pages are redirected" do
    get "/contact.php"
    assert_response :redirect
    assert_match "/contact", redirect_to_url
  end

  test "old setlists are redirected" do
    get "/setlists/2014/03_28.php"
    assert_response :redirect
    assert_match "/shows/2014-03-28", redirect_to_url
  end

  test "setlists with strange slugs are redirected" do
    get "/setlists/20100430_lovin_cup.php"
    assert_response :redirect
    assert_match "/shows/2010-04-30", redirect_to_url
  end

  test "setlists with bad slugs are redirected" do
    get "/setlists/bananas.php"
    assert_match "/setlists", redirect_to_url
  end
end
