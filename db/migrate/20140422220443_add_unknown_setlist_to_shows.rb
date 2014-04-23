class AddUnknownSetlistToShows < ActiveRecord::Migration
  def change
    add_column :shows, :unknown_setlist, :boolean, default: false, null: false
  end
end
