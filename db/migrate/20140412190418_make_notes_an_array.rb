class MakeNotesAnArray < ActiveRecord::Migration
  def change
    remove_column :slots, :notes, :string
    add_column :slots, :notes, :string, array: true, default: []
    add_index  :slots, :notes, using: 'gin'
  end
end
