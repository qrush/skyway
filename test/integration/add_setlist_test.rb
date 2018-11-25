require 'test_helper'

class AddSetlistTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as_admin
  end

  test "adding a setlist" do
    visit "/home"
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
