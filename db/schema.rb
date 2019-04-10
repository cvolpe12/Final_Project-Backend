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

ActiveRecord::Schema.define(version: 2019_04_10_132221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drafts", force: :cascade do |t|
    t.integer "team_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "participants"
    t.integer "limit"
    t.string "player_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date_of_games"
  end

  create_table "players", force: :cascade do |t|
    t.text "name"
    t.text "team"
    t.text "position"
    t.text "batting_stance"
    t.decimal "season_batting_avg"
    t.decimal "season_slugging_pct"
    t.integer "season_hits"
    t.integer "season_doubles"
    t.integer "season_triples"
    t.integer "season_home_runs"
    t.integer "season_runs"
    t.decimal "game_batting_avg"
    t.decimal "game_slugging_pct"
    t.integer "game_hits"
    t.integer "game_doubles"
    t.integer "game_triples"
    t.integer "game_home_runs"
    t.integer "game_runs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season_rbi"
    t.integer "game_rbi"
    t.integer "season_walks"
    t.integer "game_walks"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "user_id"
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
