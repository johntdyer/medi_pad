class AddDescriptionToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :description, :string
  end

  def self.down
    remove_column :types, :description
  end
end
