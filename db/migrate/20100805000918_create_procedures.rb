class CreateProcedures < ActiveRecord::Migration
  def self.up
    create_table :procedures do |t|
      t.string :procedure_name
      t.string :procedure_code
      t.string :procedure_nickname
      t.string :group_type
      t.integer :procedure_id

      t.timestamps
    end
  end

  def self.down
    drop_table :procedures
  end
end
