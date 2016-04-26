require 'test_helper'

class AddSetlistTest < ActionDispatch::IntegrationTest
  test "adding a setlist" do
    page.driver.browser.basic_authorize('admin', Skyway.admin_password)
    visit "/admin"

    click_link "Setlists"
    click_link "January 1st, 2016"
    click_link "Edit setlist"

    uncheck 'Unknown Setlist?'
    fill_in 'Setlist', with: <<SETLIST
SET I
Warren >
Origami
YYZ
SETLIST
    click_button 'Update setlist'

    assert page.has_text?("SET I: Warren > Origami, YYZ")
  end
end
