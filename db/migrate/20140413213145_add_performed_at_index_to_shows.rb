class AddPerformedAtIndexToShows < ActiveRecord::Migration
  def change
    add_index :shows, :performed_at
  end
end
