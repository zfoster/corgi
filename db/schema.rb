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

ActiveRecord::Schema.define(version: 20140908211312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "amps", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amps", ["event_id"], name: "index_amps_on_event_id", using: :btree
  add_index "amps", ["user_id"], name: "index_amps_on_user_id", using: :btree

  create_table "contributions", force: true do |t|
    t.text     "note"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_feeds", force: true do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "synced_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.integer  "price"
    t.integer  "creator_id"
    t.boolean  "closed",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.string   "url"
    t.string   "address"
    t.string   "source"
    t.string   "source_id"
    t.string   "ical_uid"
    t.integer  "event_feed_id"
    t.float    "lat"
    t.float    "lon"
    t.string   "slug"
  end

  add_index "events", ["event_feed_id"], name: "index_events_on_event_feed_id", using: :btree
  add_index "events", ["organization_id"], name: "index_events_on_organization_id", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "follows", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.string   "source"
    t.string   "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followee_id"], name: "index_follows_on_followee_id", using: :btree
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hostings", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hostings", ["event_id"], name: "index_hostings_on_event_id", using: :btree
  add_index "hostings", ["user_id"], name: "index_hostings_on_user_id", using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.hstore   "info"
    t.hstore   "credentials"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "follows_updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "org_administrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "org_administrations", ["organization_id"], name: "index_org_administrations_on_organization_id", using: :btree
  add_index "org_administrations", ["user_id"], name: "index_org_administrations_on_user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "registration_id"
    t.integer  "amount_in_cents"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.string   "last_4"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "cardholder_name"
  end

  add_index "payments", ["registration_id"], name: "index_payments_on_registration_id", using: :btree

  create_table "ranks", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["event_id"], name: "index_ranks_on_event_id", using: :btree
  add_index "ranks", ["user_id"], name: "index_ranks_on_user_id", using: :btree

  create_table "registrations", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "mobile_num"
    t.string   "avatar"
    t.integer  "default_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "name"
    t.text     "contacts"
    t.text     "pulled_events"
    t.string   "payment_token"
    t.boolean  "admin",               default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
  end

  add_index "users", ["default_identity_id"], name: "index_users_on_default_identity_id", using: :btree

end
