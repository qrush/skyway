class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :released_on
      t.string :bandcamp_url
      t.string :youtube_url
      t.timestamps
    end

    change_table :songs do |t|
      t.belongs_to :album
      t.integer :album_position
    end
  end
end
