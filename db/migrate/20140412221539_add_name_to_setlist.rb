class AddNameToSetlist < ActiveRecord::Migration
  def change
    add_column :setlists, :name, :string
  end
end
