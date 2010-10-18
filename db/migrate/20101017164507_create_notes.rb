class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.float :count
      t.string :parameter
      t.string :descriptive_data

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
