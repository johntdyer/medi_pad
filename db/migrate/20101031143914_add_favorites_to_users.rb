class AddFavoritesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :favorites, :string
  end

  def self.down
    remove_column :users, :favorites
  end
end
