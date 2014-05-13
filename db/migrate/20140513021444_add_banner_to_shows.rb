class AddBannerToShows < ActiveRecord::Migration
  def self.up
    add_attachment :shows, :banner
  end

  def self.down
    remove_attachment :shows, :banner
  end
end
