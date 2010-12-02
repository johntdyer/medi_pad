class RemoveTypeFromCharge < ActiveRecord::Migration
  def self.up 
    remove_column :charges, :type
    
  end

  def self.down
    add_column :charges, :type, :string
  end
end
