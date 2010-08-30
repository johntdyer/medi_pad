class AddPatientNameToCharges < ActiveRecord::Migration
  def self.up
    add_column :charges, :patient_name, :string
  end

  def self.down
    remove_column :charges, :patient_name
  end
end
