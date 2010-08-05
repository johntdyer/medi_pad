class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :facility
      t.string :room
      t.string :bed
      t.string :unit
      t.string :patient_name
      t.integer :age
      t.string :sex
      t.string :mrn
      t.string :fin
      t.string :attending_md
      t.string :consult_md
      t.date :admitted
      t.boolean :patient_been_seen

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
