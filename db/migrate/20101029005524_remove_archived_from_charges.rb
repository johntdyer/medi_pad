class RemoveArchivedFromCharges < ActiveRecord::Migration
  def self.up 
    remove_column :charges, :is_archived
    
  end

  def self.down 
    add_column :charges, :is_archived, :boolean
    
  end
end
