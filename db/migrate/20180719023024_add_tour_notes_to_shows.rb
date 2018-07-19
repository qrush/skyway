class AddTourNotesToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :tour_notes, :string
  end
end
