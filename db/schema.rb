# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100805001234) do

  create_table "charges", :force => true do |t|
    t.string   "procedure_name"
    t.integer  "procedure_code"
    t.string   "doctor"
    t.string   "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", :force => true do |t|
    t.string   "doctor_name"
    t.string   "doctor_id"
    t.string   "doctor_pin"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "procedures", :force => true do |t|
    t.string   "procedure_name"
    t.string   "procedure_code"
    t.string   "procedure_nickname"
    t.string   "group_type"
    t.integer  "procedure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
