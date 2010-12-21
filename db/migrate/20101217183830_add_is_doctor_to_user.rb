class AddIsDoctorToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :is_doctor, :boolean
  end

  def self.down
    remove_column :users, :is_doctor
  end
end
