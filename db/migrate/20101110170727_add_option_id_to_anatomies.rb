class AddOptionIdToAnatomies < ActiveRecord::Migration
  def self.up
    add_column :anatomies, :option_id, :integer
  end

  def self.down
    remove_column :anatomies, :option_id
  end
end
