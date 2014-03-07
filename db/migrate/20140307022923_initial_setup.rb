class InitialSetup < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, null: false, unique: true
      t.boolean :cover, null: false, default: false
      t.timestamps

      t.index :name
    end

    create_table :venues do |t|
      t.string :name, null: false
      t.timestamps

      t.index :name
    end

    create_table :shows do |t|
      t.belongs_to :venue

      t.datetime :performed_at
      t.timestamps

      t.index :venue_id
    end

    create_table :sets do |t|
      t.belongs_to :show

      t.integer :position, null: false
      t.timestamps

      t.index :show_id
    end

    create_table :slots do |t|
      t.belongs_to :set
      t.belongs_to :song

      t.integer :position, null: false
      t.boolean :debut, null: false, default: false
      t.boolean :transition, null: false, default: false
      t.text :notes
      t.timestamps

      t.index :set_id
    end
  end
end
