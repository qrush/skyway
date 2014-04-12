class RenameSetIdOnSlots < ActiveRecord::Migration
  def change
    rename_column :slots, :set_id, :setlist_id
  end
end
