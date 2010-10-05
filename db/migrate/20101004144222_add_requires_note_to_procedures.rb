class AddRequiresNoteToProcedures < ActiveRecord::Migration
  def self.up
    add_column :procedures, :note_required, :boolean
  end

  def self.down
    remove_column :procedures, :note_required
  end
end
