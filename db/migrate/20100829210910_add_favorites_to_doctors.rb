class AddFavoritesToDoctors < ActiveRecord::Migration
  def self.up
    add_column :doctors, :favorites, :string
  end

  def self.down
    remove_column :doctors, :favorites
  end
end
