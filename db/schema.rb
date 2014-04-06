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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140402094505) do

  create_table "bbs_threads", force: true do |t|
    t.integer  "plate_id"
    t.string   "name"
    t.datetime "updated_at"
  end

  add_index "bbs_threads", ["plate_id"], name: "index_bbs_threads_on_plate_id", using: :btree

  create_table "contexts", force: true do |t|
    t.integer  "user_id"
    t.integer  "bbs_thread_id"
    t.integer  "no"
    t.text     "description"
    t.datetime "created_at"
  end

  add_index "contexts", ["bbs_thread_id", "no"], name: "index_contexts_on_bbs_thread_id_and_no", unique: true, using: :btree
  add_index "contexts", ["bbs_thread_id"], name: "index_contexts_on_bbs_thread_id", using: :btree
  add_index "contexts", ["no"], name: "index_contexts_on_no", using: :btree

  create_table "plates", force: true do |t|
    t.string "name"
  end

  create_table "user_plates", force: true do |t|
    t.string "user_id"
    t.string "plate_id"
  end

  add_index "user_plates", ["plate_id"], name: "index_user_plates_on_plate_id", using: :btree
  add_index "user_plates", ["user_id", "plate_id"], name: "index_user_plates_on_user_id_and_plate_id", unique: true, using: :btree
  add_index "user_plates", ["user_id"], name: "index_user_plates_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "super_admin",     default: false
    t.boolean  "admin",           default: false
    t.boolean  "enable",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
