class AddNoteToCharges < ActiveRecord::Migration
  def self.up
    add_column :charges, :note, :string
  end

  def self.down
    remove_column :charges, :note
  end
end
