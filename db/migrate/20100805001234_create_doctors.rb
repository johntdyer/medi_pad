class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.string :doctor_name
      t.string :doctor_id
      t.string :doctor_pin

      t.timestamps
    end
  end

  def self.down
    drop_table :doctors
  end
end
