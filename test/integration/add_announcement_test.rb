require 'test_helper'

class AddAnnouncementTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as_admin
  end

  test "adding an announcement" do
    click_link "Edit home"

    fill_in "What's new?", with: "Here's some great news about the band!"
    fill_in "Featured YouTube URL", with: "https://www.youtube.com/watch?v=xSoIO6HkSUc"
    click_button 'Create Announcement'

    assert page.has_text?("Here's some great news about the band!")
    assert page.has_css?("iframe[src*='embed/xSoIO6HkSUc']")
  end
end
