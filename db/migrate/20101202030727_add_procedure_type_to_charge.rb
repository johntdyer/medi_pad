class AddProcedureTypeToCharge < ActiveRecord::Migration
  def self.up
    add_column :charges, :procedure_type, :string
  end

  def self.down
    remove_column :charges, :procedure_type
  end
end
