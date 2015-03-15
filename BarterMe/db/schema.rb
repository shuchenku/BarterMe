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

ActiveRecord::Schema.define(version: 20150315051423) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "similar_category"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.integer  "product_key"
    t.integer  "type_id"
    t.string   "location"
    t.integer  "quantity"
    t.integer  "post_date"
    t.integer  "test2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "category1"
    t.integer  "category2"
    t.integer  "category3"
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "line_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["item_id"], name: "index_line_items_on_item_id"

  create_table "offers", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "offer_id"
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "item1_id"
    t.integer  "item2_id"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["item_id"], name: "index_offers_on_item_id"
  add_index "offers", ["user_id"], name: "index_offers_on_user_id"

  create_table "offers_users", force: true do |t|
    t.integer "offers_id"
    t.integer "users_id"
  end

  create_table "users", force: true do |t|
    t.string   "user_id"
    t.string   "user_name"
    t.string   "password"
    t.string   "email"
    t.string   "phone"
    t.integer  "reliability"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "looking_for"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.integer  "cart_id"
  end

end
