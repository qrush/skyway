class AddNotesToShows < ActiveRecord::Migration
  def change
    add_column :shows, :notes, :string, array: true, default: []
    add_index  :shows, :notes, using: 'gin'
  end
end
