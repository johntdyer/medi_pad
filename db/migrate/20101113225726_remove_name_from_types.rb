class RemoveNameFromTypes < ActiveRecord::Migration
  def self.up
    remove_column :types, :name
  end

  def self.down
    add_column :types, :name, :string
  end
end
