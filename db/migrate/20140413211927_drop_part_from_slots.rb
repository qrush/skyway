class DropPartFromSlots < ActiveRecord::Migration
  def change
    remove_column :slots, :part, :integer
    add_index :slots, :song_id
  end
end
