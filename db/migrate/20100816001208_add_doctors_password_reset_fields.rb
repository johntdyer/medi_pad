class AddDoctorsPasswordResetFields < ActiveRecord::Migration
  def self.up  
    add_column :doctors, :perishable_token, :string, :default => "", :null => false
    add_index :doctors, :perishable_token
  end
  
  def self.down
    remove_column :doctors, :perishable_token
  end
end
