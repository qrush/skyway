class AddEmbedsToShows < ActiveRecord::Migration
  def change
    add_column :shows, :embeds, :text
  end
end
