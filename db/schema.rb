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

ActiveRecord::Schema.define(version: 20131002184723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "contributions", force: true do |t|
    t.text     "note"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "info"
    t.hstore   "credentials"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "shares", force: true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_objects", force: true do |t|
    t.integer  "corgi_foreign_key"
    t.datetime "corgi_create_date"
    t.string   "type"
    t.string   "title"
    t.text     "description"
    t.string   "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "mobile_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

end
