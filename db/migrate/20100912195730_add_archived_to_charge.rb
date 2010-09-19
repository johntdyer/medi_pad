class AddArchivedToCharge < ActiveRecord::Migration
  def self.up
    add_column :charges, :is_archived, :boolean
  end

  def self.down
    remove_column :charges, :is_archived
  end
end
