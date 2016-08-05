require 'test_helper'

class Auth0ControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get auth0_callback_url
    assert_response :success
  end

  test "should get failure" do
    get auth0_failure_url
    assert_response :success
  end

end
