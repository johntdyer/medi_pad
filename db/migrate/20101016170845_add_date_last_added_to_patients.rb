class AddDateLastAddedToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :date_last_added, :datetime
  end

  def self.down
    remove_column :patients, :date_last_added
  end
end
