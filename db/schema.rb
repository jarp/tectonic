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

ActiveRecord::Schema.define(version: 20160720212424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonus", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "plate_id"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_bonus_on_game_id", using: :btree
    t.index ["plate_id"], name: "index_bonus_on_plate_id", using: :btree
  end

  create_table "spoils", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "plate_id"
    t.integer  "points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "current_coord"
    t.string   "state_coord"
    t.index ["game_id"], name: "index_spoils_on_game_id", using: :btree
    t.index ["plate_id"], name: "index_spoils_on_plate_id", using: :btree
    t.index ["player_id"], name: "index_spoils_on_player_id", using: :btree
  end

  create_table "game_players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.boolean  "accepted",   default: false
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "token"
    t.boolean  "use_images"
    t.integer  "player_id"
    t.boolean  "is_completed",           default: false
    t.datetime "completed_at"
    t.integer  "bonus_count"
    t.integer  "tour_id"
    t.boolean  "allow_player_switching"
    t.index ["game_type_id"], name: "index_games_on_game_type_id", using: :btree
    t.index ["player_id"], name: "index_games_on_player_id", using: :btree
    t.index ["tour_id"], name: "index_games_on_tour_id", using: :btree
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

  create_table "timelines", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "plate_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_timelines_on_game_id", using: :btree
    t.index ["plate_id"], name: "index_timelines_on_plate_id", using: :btree
    t.index ["player_id"], name: "index_timelines_on_player_id", using: :btree
  end

  create_table "tours", force: :cascade do |t|
    t.string   "name"
    t.date     "start_on"
    t.date     "end_on"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_tours_on_player_id", using: :btree
  end

  add_foreign_key "bonus", "games"
  add_foreign_key "bonus", "plates"
  add_foreign_key "spoils", "games"
  add_foreign_key "spoils", "plates"
  add_foreign_key "spoils", "players"
  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "players"
  add_foreign_key "games", "game_types"
  add_foreign_key "games", "players"
  add_foreign_key "games", "tours"
  add_foreign_key "timelines", "games"
  add_foreign_key "timelines", "plates"
  add_foreign_key "timelines", "players"
  add_foreign_key "tours", "players"
end
