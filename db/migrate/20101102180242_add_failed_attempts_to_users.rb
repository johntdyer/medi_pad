class AddFailedAttemptsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :failed_attempts, :integer
  end

  def self.down
    remove_column :users, :failed_attempts
  end
end
