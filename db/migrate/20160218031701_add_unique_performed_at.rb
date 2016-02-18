class AddUniquePerformedAt < ActiveRecord::Migration
  def up
    remove_index :shows, :performed_at
    change_column :shows, :performed_at, :date
    change_column :imported_shows, :performed_at, :date

    add_index :shows, :performed_at, unique: true
    add_index :imported_shows, :performed_at, unique: true
  end

  def down
    remove_index :shows, :performed_at
    remove_index :imported_shows, :performed_at

    change_column :shows, :performed_at, :datetime
    change_column :imported_shows, :performed_at, :datetime
    add_index :shows, :performed_at
  end
end
