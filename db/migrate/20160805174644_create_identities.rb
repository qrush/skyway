class CreateIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :fans do |t|
      t.string :handle, index: true, unique: true
      t.string :picture
      t.timestamps
    end

    create_table :identities do |t|
      t.string :user_id, unique: true, index: true, null: false
      t.belongs_to :fan
      t.timestamps
    end

    create_table :attendances do |t|
      t.belongs_to :fan
      t.belongs_to :show
      t.index [:fan_id, :show_id], unique: true
    end
  end
end
