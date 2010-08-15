class AddFieldnameToDoctors < ActiveRecord::Migration
  def self.up
    add_column :doctors, :email, :string
  end

  def self.down
    remove_column :doctors, :email
  end
end
