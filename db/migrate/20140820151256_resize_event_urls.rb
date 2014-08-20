class ResizeEventUrls < ActiveRecord::Migration
  def change
    change_column :venues, :url, :text
    change_column :shows, :url, :text
  end
end
