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

ActiveRecord::Schema.define(version: 20160712175535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "finds", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "plate_id"
    t.integer  "points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "current_coord"
    t.string   "state_coord"
    t.index ["game_id"], name: "index_finds_on_game_id", using: :btree
    t.index ["plate_id"], name: "index_finds_on_plate_id", using: :btree
    t.index ["player_id"], name: "index_finds_on_player_id", using: :btree
  end

  create_table "game_players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.boolean  "accepted"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "originator", default: false
    t.string   "token"
    t.index ["game_id"], name: "index_game_players_on_game_id", using: :btree
    t.index ["player_id"], name: "index_game_players_on_player_id", using: :btree
  end

  create_table "game_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.integer  "game_type_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "token"
    t.boolean  "use_images"
    t.integer  "player_id"
    t.boolean  "is_completed", default: false
    t.datetime "completed_at"
    t.index ["game_type_id"], name: "index_games_on_game_type_id", using: :btree
    t.index ["player_id"], name: "index_games_on_player_id", using: :btree
  end

  create_table "plates", force: :cascade do |t|
    t.string   "state"
    t.string   "geocode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "players", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "is_super"
    t.string   "image"
  end

  add_foreign_key "finds", "games"
  add_foreign_key "finds", "plates"
  add_foreign_key "finds", "players"
  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "players"
  add_foreign_key "games", "game_types"
  add_foreign_key "games", "players"
end
