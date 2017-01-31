class AddIndexToLyrics < ActiveRecord::Migration[5.0]
  def change
    add_index :songs, :lyrics
  end
end
