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

ActiveRecord::Schema.define(version: 20180719023024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.date     "released_on"
    t.string   "bandcamp_url"
    t.string   "youtube_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

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

  create_table "attendances", force: :cascade do |t|
    t.integer "fan_id"
    t.integer "show_id"
    t.index ["fan_id", "show_id"], name: "index_attendances_on_fan_id_and_show_id", unique: true, using: :btree
    t.index ["fan_id"], name: "index_attendances_on_fan_id", using: :btree
    t.index ["show_id"], name: "index_attendances_on_show_id", using: :btree
  end

  create_table "fans", force: :cascade do |t|
    t.string   "handle"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["handle"], name: "index_fans_on_handle", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.string   "user_id",    null: false
    t.integer  "fan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fan_id"], name: "index_identities_on_fan_id", using: :btree
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
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
    t.index ["performed_at"], name: "index_imported_shows_on_performed_at", unique: true, using: :btree
  end

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
    t.index ["show_id"], name: "index_setlists_on_show_id", using: :btree
  end

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
    t.string   "tour_notes"
    t.index ["embeds"], name: "index_shows_on_embeds", using: :btree
    t.index ["notes"], name: "index_shows_on_notes", using: :gin
    t.index ["performed_at"], name: "index_shows_on_performed_at", using: :btree
    t.index ["venue_id"], name: "index_shows_on_venue_id", using: :btree
  end

  create_table "slots", force: :cascade do |t|
    t.integer  "setlist_id"
    t.integer  "song_id"
    t.integer  "position",                               null: false
    t.boolean  "transition",             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",      limit: 255, default: [],                 array: true
    t.index ["notes"], name: "index_slots_on_notes", using: :gin
    t.index ["setlist_id"], name: "index_slots_on_setlist_id", using: :btree
    t.index ["song_id"], name: "index_slots_on_song_id", using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.string   "name",           limit: 255,                 null: false
    t.boolean  "cover",                      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shows_count",                default: 0,     null: false
    t.text     "lyrics"
    t.text     "history"
    t.integer  "album_id"
    t.integer  "album_position"
    t.index ["album_id"], name: "index_songs_on_album_id", using: :btree
    t.index ["lyrics"], name: "index_songs_on_lyrics", using: :btree
    t.index ["name"], name: "index_songs_on_name", unique: true, using: :btree
    t.index ["shows_count"], name: "index_songs_on_shows_count", using: :btree
  end

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
    t.index ["latitude", "longitude"], name: "index_venues_on_latitude_and_longitude", using: :btree
    t.index ["name"], name: "index_venues_on_name", using: :btree
  end

end
