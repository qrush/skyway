class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.text :csv, null: false
      t.timestamps null: false
    end

    create_table :imported_shows do |t|
      t.datetime :performed_at
      t.time :starts_at
      t.string :price
      t.text :url
      t.belongs_to :venue
      t.belongs_to :imported_venue
      t.belongs_to :import
      t.timestamps null: false
    end

    create_table :imported_venues do |t|
      t.string :name, null: false
      t.string :location
      t.string :address
      t.belongs_to :import
      t.timestamps null: false
    end
  end
end
