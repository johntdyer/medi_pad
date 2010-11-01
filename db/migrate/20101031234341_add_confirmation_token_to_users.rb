class AddConfirmationTokenToUsers < ActiveRecord::Migration
  def self.up  
    add_column :users, :confirmation_token, :string, :limit => 255    
    add_index :users, :confirmation_token,   :unique => true  
  end

  def self.down 
    remove_column :users, :confirmation_token,   :unique => true  
  end
end
