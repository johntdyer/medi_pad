class AddLocalityToCharge < ActiveRecord::Migration
  def self.up
    add_column :charges, :locality, :string
  end

  def self.down
    remove_column :charges, :locality
  end
end
