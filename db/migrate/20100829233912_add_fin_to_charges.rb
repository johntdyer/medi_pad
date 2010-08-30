class AddFinToCharges < ActiveRecord::Migration
  def self.up
    add_column :charges, :fin, :string
  end

  def self.down
    remove_column :charges, :fin
  end
end
