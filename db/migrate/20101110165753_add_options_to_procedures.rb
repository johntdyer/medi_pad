class AddOptionsToProcedures < ActiveRecord::Migration
  def self.up
    add_column :procedures, :options, :string
  end

  def self.down
    remove_column :procedures, :options
  end
end
