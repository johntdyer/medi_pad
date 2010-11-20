class AddLocationToType < ActiveRecord::Migration
  def self.up
    add_column :types, :location, :string
  end

  def self.down
    remove_column :types, :location
  end
end
