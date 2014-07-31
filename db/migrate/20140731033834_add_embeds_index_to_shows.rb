class AddEmbedsIndexToShows < ActiveRecord::Migration
  def change
    add_index :shows, :embeds
  end
end
