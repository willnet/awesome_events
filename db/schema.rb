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

ActiveRecord::Schema.define(version: 20131117134312) do

  create_table "events", force: true do |t|
    t.integer  "owner_id"
    t.string   "name",        null: false
    t.string   "place",       null: false
    t.datetime "start_time",  null: false
    t.datetime "end_time",    null: false
    t.text     "content",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_image"
  end

  add_index "events", ["owner_id"], name: "index_events_on_owner_id"

  create_table "tickets", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id",   null: false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["event_id", "user_id"], name: "index_tickets_on_event_id_and_user_id", unique: true
  add_index "tickets", ["user_id", "event_id"], name: "index_tickets_on_user_id_and_event_id", unique: true

  create_table "users", force: true do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "nickname",   null: false
    t.string   "image_url",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true

end
