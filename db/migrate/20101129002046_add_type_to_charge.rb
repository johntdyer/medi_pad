class AddTypeToCharge < ActiveRecord::Migration
  def self.up
    add_column :charges, :type, :string
  end

  def self.down
    remove_column :charges, :type
  end
end
