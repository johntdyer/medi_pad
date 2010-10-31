# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101031143914) do

  create_table "charges", :force => true do |t|
    t.string   "procedure_name"
    t.integer  "procedure_code"
    t.string   "doctor"
    t.string   "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "recorded",       :default => false
    t.string   "fin"
    t.string   "patient_name"
    t.string   "note"
  end

  create_table "doctors", :force => true do |t|
    t.string   "doctor_name"
    t.string   "username"
    t.string   "email"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_login_at"
    t.datetime "last_request_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",   :default => "", :null => false
    t.string   "favorites"
  end

  add_index "doctors", ["perishable_token"], :name => "index_doctors_on_perishable_token"

  create_table "imports", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "patient_data_file_name"
    t.string   "patient_data_content_type"
    t.integer  "patient_data_file_size"
    t.datetime "patient_data_updated_at"
  end

  create_table "notes", :force => true do |t|
    t.float    "count"
    t.string   "parameter"
    t.string   "descriptive_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "charge_id"
  end

  create_table "patients", :force => true do |t|
    t.string   "facility"
    t.string   "room"
    t.string   "bed"
    t.string   "unit"
    t.string   "patient_name"
    t.integer  "age"
    t.string   "sex"
    t.string   "mrn"
    t.string   "fin"
    t.string   "attending_md"
    t.string   "consult_md"
    t.date     "admitted"
    t.boolean  "patient_been_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "discharged"
    t.datetime "date_last_added"
    t.string   "charges"
  end

  create_table "procedures", :force => true do |t|
    t.string   "procedure_name"
    t.string   "procedure_code"
    t.string   "procedure_nickname"
    t.string   "group_type"
    t.integer  "procedure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "note_required"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "favorites"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
