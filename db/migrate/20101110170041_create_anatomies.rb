class CreateAnatomies < ActiveRecord::Migration
  def self.up
    create_table :anatomies do |t|
      t.string :description
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :anatomies
  end
end
