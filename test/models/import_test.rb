require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  test "importing" do
    import = import("tour")

    assert import.persisted?, "Import failed"

    show = import.imported_shows.first
    assert_not_nil show

    assert_equal "2016-02-25", show.performed_at.to_date.to_s
    assert_equal "09:00 PM", show.starts_at.strftime("%I:%M %p")
    assert_equal "5", show.price
    assert_not_nil show.url

    venue = show.imported_venue
    assert_not_nil venue
    assert_equal "Winchester, VA", venue.location
    assert_equal "Bright Box Theater", venue.name
  end

  test "importing with invalid CSV" do
    import = Import.create(csv: "bananas" * 10)

    assert import.new_record?, "Import succeeded"
  end

  test "imports without venue" do
    import = import("no_venue")

    assert import.new_record?, "Import succeeded"
  end

  test "imports with existing venue" do
    import = import("existing_venue")

    assert import.persisted?, "Import failed"

    show = import.imported_shows.first
    assert_equal venues(:bar), show.venue
    assert_nil show.imported_venue
  end

  test "import with no admission" do
    import = import("no_admission")

    assert import.persisted?, "Import failed"
  end

  private

    def import(name)
      Import.create(csv: Rails.root.join("test/fixtures/imports/#{name}.csv").read)
    end
end
