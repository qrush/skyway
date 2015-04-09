class AddVideoToAnnouncements < ActiveRecord::Migration
  def change
    change_table :announcements do |t|
      t.string :video
    end
  end
end
