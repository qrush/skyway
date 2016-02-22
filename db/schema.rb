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

ActiveRecord::Schema.define(version: 20160222183200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "draft",              default: true, null: false
    t.datetime "published_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "facebook_image_url"
  end

  create_table "imported_shows", force: :cascade do |t|
    t.date     "performed_at"
    t.time     "starts_at"
    t.string   "price"
    t.text     "url"
    t.integer  "venue_id"
    t.integer  "imported_venue_id"
    t.integer  "import_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "imported_shows", ["performed_at"], name: "index_imported_shows_on_performed_at", unique: true, using: :btree

  create_table "imported_venues", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "location"
    t.string   "address"
    t.integer  "import_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imports", force: :cascade do |t|
    t.text     "csv",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setlists", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "position",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  add_index "setlists", ["show_id"], name: "index_setlists_on_show_id", using: :btree

  create_table "shows", force: :cascade do |t|
    t.integer  "venue_id"
    t.date     "performed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",               limit: 255, default: [],                 array: true
    t.boolean  "unknown_setlist",                 default: false, null: false
    t.string   "banner_file_name",    limit: 255
    t.string   "banner_content_type", limit: 255
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.text     "embeds"
    t.text     "url"
    t.string   "price",               limit: 255
    t.string   "age_restriction",     limit: 255
    t.time     "starts_at"
    t.text     "extra_notes"
    t.boolean  "featured",                        default: false, null: false
  end

  add_index "shows", ["embeds"], name: "index_shows_on_embeds", using: :btree
  add_index "shows", ["notes"], name: "index_shows_on_notes", using: :gin
  add_index "shows", ["performed_at"], name: "index_shows_on_performed_at", using: :btree
  add_index "shows", ["venue_id"], name: "index_shows_on_venue_id", using: :btree

  create_table "slots", force: :cascade do |t|
    t.integer  "setlist_id"
    t.integer  "song_id"
    t.integer  "position",                               null: false
    t.boolean  "transition",             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",      limit: 255, default: [],                 array: true
  end

  add_index "slots", ["notes"], name: "index_slots_on_notes", using: :gin
  add_index "slots", ["setlist_id"], name: "index_slots_on_setlist_id", using: :btree
  add_index "slots", ["song_id"], name: "index_slots_on_song_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name",        limit: 255,                 null: false
    t.boolean  "cover",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shows_count",             default: 0,     null: false
    t.text     "lyrics"
    t.text     "history"
  end

  add_index "songs", ["name"], name: "index_songs_on_name", unique: true, using: :btree
  add_index "songs", ["shows_count"], name: "index_songs_on_shows_count", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location",   limit: 255
    t.text     "url"
    t.string   "address",    limit: 255
    t.string   "twitter",    limit: 255
    t.string   "facebook",   limit: 255
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "venues", ["latitude", "longitude"], name: "index_venues_on_latitude_and_longitude", using: :btree
  add_index "venues", ["name"], name: "index_venues_on_name", using: :btree

end
