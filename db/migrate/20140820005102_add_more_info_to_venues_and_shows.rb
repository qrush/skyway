class AddMoreInfoToVenuesAndShows < ActiveRecord::Migration
  def change
    change_table :venues do |t|
      t.string :url
      t.string :address
      t.string :twitter
      t.string :facebook
    end

    change_table :shows do |t|
      t.string :url
      t.string :price
      t.string :age_restriction
      t.time :starts_at
    end
  end
end
