class AddLatitudeAndLongitudeToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :latitude, :float
    add_column :venues, :longitude, :float
    add_index :venues, [:latitude, :longitude]
  end
end
