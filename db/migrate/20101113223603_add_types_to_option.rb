class AddTypesToOption < ActiveRecord::Migration
  def self.up
    add_column :options, :types, :string
  end

  def self.down
    remove_column :options, :types
  end
end
