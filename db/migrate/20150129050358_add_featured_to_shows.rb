class AddFeaturedToShows < ActiveRecord::Migration
  def change
    change_table :shows do |t|
      t.boolean :featured, default: false, null: false
    end
  end
end
