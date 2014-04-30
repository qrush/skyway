class AddCounterCacheToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :shows_count, :integer, default: 0, null: false
    add_index :songs, :shows_count
  end
end
