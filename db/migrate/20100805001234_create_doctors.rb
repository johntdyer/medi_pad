class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.string :doctor_name
      t.string :username
      t.string :email
      t.string :current_login_ip
      t.string :last_login_ip
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :last_login_at
      t.datetime :last_request_at
      t.timestamps
    end
  end

  def self.down
    drop_table :doctors
  end
end
