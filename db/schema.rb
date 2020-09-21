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

ActiveRecord::Schema.define(version: 20180411212045) do

  create_table "jobs", force: :cascade do |t|
    t.boolean  "status"
    t.integer  "dependant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "label"
    t.string   "name"
  end

  create_table "songs", force: :cascade do |t|
    t.text    "lyric"
    t.string  "title"
    t.string  "writers"
    t.text    "copyright"
    t.boolean "active"
    t.string  "youtube"
    t.string  "facebook"
    t.string  "soundcloud"
  end

  create_table "welcomes", force: :cascade do |t|
    t.string   "bandName"
    t.string   "headline"
    t.string   "message"
    t.string   "logo"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "destroy_count"
    t.integer  "restart_count"
    t.boolean  "deathOrLife"
  end

end
