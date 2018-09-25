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

ActiveRecord::Schema.define(version: 2018_09_25_135756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "p1_id"
    t.integer "p2_id"
    t.integer "p3_id"
    t.integer "p4_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_games_on_name"
    t.index ["p1_id"], name: "index_games_on_p1_id"
    t.index ["p2_id"], name: "index_games_on_p2_id"
    t.index ["p3_id"], name: "index_games_on_p3_id"
    t.index ["p4_id"], name: "index_games_on_p4_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_players_on_email"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "game_id"
    t.integer "s1"
    t.integer "s2"
    t.integer "s3"
    t.integer "s4"
    t.integer "roundtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_rounds_on_game_id"
  end

  add_foreign_key "rounds", "games"
end
