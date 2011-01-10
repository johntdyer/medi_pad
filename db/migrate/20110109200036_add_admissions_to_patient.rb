class AddAdmissionsToPatient < ActiveRecord::Migration
  def self.up
    add_column :patients, :admissions, :string
  end

  def self.down
    remove_column :patients, :admissions
  end
end
