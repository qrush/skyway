class RemoveUniquePerformedAtForNow < ActiveRecord::Migration
  def up
    remove_index :shows, :performed_at
    add_index :shows, :performed_at
  end

  def down
    remove_index :shows, :performed_at
    add_index :shows, :performed_at, unique: true
  end
end
