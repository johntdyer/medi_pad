class AddOptionIdToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :option_id, :integer
  end

  def self.down
    remove_column :types, :option_id
  end
end
