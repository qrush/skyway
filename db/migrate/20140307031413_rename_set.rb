class RenameSet < ActiveRecord::Migration
  def change
    rename_table :sets, :setlists
  end
end
