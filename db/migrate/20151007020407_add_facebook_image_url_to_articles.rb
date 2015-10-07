class AddFacebookImageUrlToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.string :facebook_image_url
    end
  end
end
