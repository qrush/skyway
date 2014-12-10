class AddExtraNotesToShows < ActiveRecord::Migration
  def change
    change_table :shows do |t|
      t.text :extra_notes
    end

    change_table :songs do |t|
      t.text :lyrics
      t.text :history
    end
  end
end
