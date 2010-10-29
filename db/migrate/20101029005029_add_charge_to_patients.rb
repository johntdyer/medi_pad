class AddChargeToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :charges, :string
  end

  def self.down
    remove_column :patients, :charges
  end
end
