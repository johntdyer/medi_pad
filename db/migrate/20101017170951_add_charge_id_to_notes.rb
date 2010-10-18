class AddChargeIdToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :charge_id, :integer
  end

  def self.down
    remove_column :notes, :charge_id
  end
end
