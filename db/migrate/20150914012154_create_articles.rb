class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :draft, default: true, null: false
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
