class AddRecordedToCharges < ActiveRecord::Migration
  def self.up
    add_column :charges, :recorded, :boolean
  end

  def self.down
    remove_column :charges, :recorded
  end
end
