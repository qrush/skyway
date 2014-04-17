class RemoveDebutFromSlots < ActiveRecord::Migration
  def change
    remove_column :slots, :debut, :boolean
  end
end
