class AddPartToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :part, :integer, default: 0
  end
end
