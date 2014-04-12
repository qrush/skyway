class AddUniqueIndexToSongsForName < ActiveRecord::Migration
  def change
    remove_index :songs, column: :name
    add_index :songs, :name, unique: true
  end
end
