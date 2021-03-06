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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140304095344) do

  create_table "abilities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ability_upgrades", :force => true do |t|
    t.integer  "ability_id"
    t.integer  "time"
    t.integer  "level"
    t.integer  "player_match_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "additional_units", :force => true do |t|
    t.string   "unitname"
    t.integer  "item_0"
    t.integer  "item_1"
    t.integer  "item_2"
    t.integer  "item_3"
    t.integer  "item_4"
    t.integer  "item_5"
    t.integer  "player_match_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "heros", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "image_url"
    t.string   "localized_name"
    t.text     "thumb_url"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.text     "url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "localized_name"
    t.text     "description"
  end

  create_table "match_teams", :force => true do |t|
    t.integer  "match_id"
    t.integer  "radiant_team_id"
    t.string   "radiant_logo"
    t.integer  "dire_team_id"
    t.string   "dire_logo"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "radiant_team_complete"
    t.integer  "dire_team_complete"
    t.integer  "radiant_guild_id"
    t.integer  "dire_guild_id"
    t.integer  "radiant_guild_name"
    t.integer  "dire_guild_name"
    t.string   "radiant_guild_logo"
    t.string   "dire_guild_logo"
  end

  create_table "matches", :force => true do |t|
    t.boolean  "radiant_win"
    t.integer  "duration"
    t.integer  "game_mode"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "match_seq_num"
    t.integer  "start_time"
    t.integer  "lobby_type"
    t.integer  "tower_status_radiant"
    t.integer  "tower_status_dire"
    t.integer  "barracks_status_radiant"
    t.integer  "barracks_status_dire"
    t.integer  "cluster"
    t.integer  "first_blood_time"
    t.integer  "human_players"
    t.integer  "positive_votes"
    t.integer  "negative_votes"
    t.integer  "league_id"
  end

  create_table "pick_bans", :force => true do |t|
    t.boolean  "is_pick"
    t.integer  "hero_id"
    t.integer  "team"
    t.integer  "order"
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "player_matches", :force => true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "player_slot"
    t.integer  "hero_id"
    t.integer  "item_0"
    t.integer  "item_1"
    t.integer  "item_2"
    t.integer  "item_3"
    t.integer  "item_4"
    t.integer  "item_5"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "gold"
    t.integer  "last_hits"
    t.integer  "denies"
    t.integer  "gold_per_min"
    t.integer  "xp_per_min"
    t.integer  "gold_spent"
    t.integer  "level"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "hero_damage"
    t.integer  "tower_damage"
    t.integer  "hero_healing"
    t.integer  "leaver_status"
  end

  create_table "player_teams", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scrims", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "match_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "approved"
    t.string   "server"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "country_code"
    t.text     "url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.text     "avatar_url"
  end

end
