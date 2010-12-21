class AddIsBillingToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :is_billing, :boolean
  end

  def self.down
    remove_column :users, :is_billing
  end
end
