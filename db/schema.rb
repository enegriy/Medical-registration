# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 30) do

  create_table "absences", :force => true do |t|
    t.string "title"
  end

  create_table "blacklists", :force => true do |t|
    t.integer "doctor_id"
    t.integer "user_id"
    t.date    "lock_to"
  end

  create_table "cities", :force => true do |t|
    t.string  "name",      :limit => 60
    t.integer "region_id"
  end

  add_index "cities", ["region_id"], :name => "index_cities_on_region_id"

  create_table "dayofweeks", :force => true do |t|
    t.string "name"
  end

  create_table "daytypes", :force => true do |t|
    t.string "name"
  end

  create_table "doctor_absences", :force => true do |t|
    t.datetime "absence_date"
    t.integer  "absence_id"
    t.integer  "doctor_id"
  end

  create_table "doctors", :force => true do |t|
    t.string   "soname"
    t.string   "name"
    t.string   "second_name"
    t.date     "birth_date"
    t.string   "photo_path"
    t.text     "note"
    t.integer  "spec_id"
    t.integer  "organization_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "work_phone",          :limit => 20
    t.string   "position_photo",      :limit => 1
    t.integer  "experience"
    t.boolean  "is_come_home"
    t.boolean  "is_send_visits"
    t.date     "old_date_sendvisits"
  end

  add_index "doctors", ["organization_id"], :name => "index_doctors_on_organization_id"
  add_index "doctors", ["spec_id"], :name => "index_doctors_on_spec_id"

  create_table "menu_link_roles", :force => true do |t|
    t.integer "role_id"
    t.integer "menu_id"
  end

  add_index "menu_link_roles", ["menu_id"], :name => "index_menu_link_roles_on_menu_id"
  add_index "menu_link_roles", ["role_id"], :name => "index_menu_link_roles_on_role_id"

  create_table "menus", :force => true do |t|
    t.string "title"
    t.string "controller"
    t.string "action"
  end

  create_table "organizations", :force => true do |t|
    t.string  "name",    :limit => 100
    t.string  "street",  :limit => 50
    t.integer "number"
    t.integer "city_id"
  end

  add_index "organizations", ["city_id"], :name => "index_organizations_on_city_id"

  create_table "prog_options", :id => false, :force => true do |t|
    t.string "option", :limit => 60
    t.string "value",  :limit => 100
  end

  add_index "prog_options", ["option"], :name => "index_prog_options_on_option", :unique => true

  create_table "regions", :force => true do |t|
    t.string "name", :limit => 60
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "specs", :force => true do |t|
    t.string "name"
  end

  create_table "tickets", :force => true do |t|
    t.datetime "visit_date"
    t.integer  "doctor_id"
    t.integer  "user_id"
  end

  add_index "tickets", ["doctor_id"], :name => "index_tickets_on_doctor_id"
  add_index "tickets", ["user_id"], :name => "index_tickets_on_user_id"

  create_table "timetables", :force => true do |t|
    t.time     "time_for"
    t.time     "time_to"
    t.integer  "time_of_visit"
    t.integer  "daytype_id"
    t.integer  "dayofweek_id"
    t.integer  "doctor_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "timetables", ["dayofweek_id"], :name => "index_timetables_on_dayofweek_id"
  add_index "timetables", ["daytype_id"], :name => "index_timetables_on_daytype_id"
  add_index "timetables", ["doctor_id"], :name => "index_timetables_on_doctor_id"

  create_table "users", :force => true do |t|
    t.string   "login",      :null => false
    t.string   "password",   :null => false
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role_id"
    t.integer  "doctor_id"
    t.string   "email"
  end

  add_index "users", ["doctor_id"], :name => "index_users_on_doctor_id"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
