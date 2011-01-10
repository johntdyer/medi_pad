class CreateAdmissions < ActiveRecord::Migration
  def self.up
    create_table :admissions do |t|
      t.references :patient
      t.date :checkin
      t.date :checkout
      t.timestamps
    end
  end

  def self.down
    drop_table :admissions
  end
end
