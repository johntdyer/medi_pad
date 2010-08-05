class CreateCharges < ActiveRecord::Migration
  def self.up
    create_table :charges do |t|
      t.string :procedure_name
      t.integer :procedure_code
      t.string :doctor
      t.string :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :charges
  end
end
