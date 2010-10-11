class AddDischargedToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :discharged, :boolean
  end

  def self.down
    remove_column :patients, :discharged
  end
end
