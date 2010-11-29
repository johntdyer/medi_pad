class AddOptionToCharge < ActiveRecord::Migration
  def self.up
    add_column :charges, :option, :string
  end

  def self.down
    remove_column :charges, :option
  end
end
