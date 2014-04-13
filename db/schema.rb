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

ActiveRecord::Schema.define(version: 20140413211927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "setlists", force: true do |t|
    t.integer  "show_id"
    t.integer  "position",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "setlists", ["show_id"], name: "index_setlists_on_show_id", using: :btree

  create_table "shows", force: true do |t|
    t.integer  "venue_id"
    t.datetime "performed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shows", ["venue_id"], name: "index_shows_on_venue_id", using: :btree

  create_table "slots", force: true do |t|
    t.integer  "setlist_id"
    t.integer  "song_id"
    t.integer  "position",                   null: false
    t.boolean  "debut",      default: false, null: false
    t.boolean  "transition", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",      default: [],                 array: true
  end

  add_index "slots", ["notes"], name: "index_slots_on_notes", using: :gin
  add_index "slots", ["setlist_id"], name: "index_slots_on_setlist_id", using: :btree
  add_index "slots", ["song_id"], name: "index_slots_on_song_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "name",                       null: false
    t.boolean  "cover",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["name"], name: "index_songs_on_name", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["name"], name: "index_venues_on_name", using: :btree

end
