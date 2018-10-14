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

ActiveRecord::Schema.define(version: 2018_10_14_071605) do

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer "item_id"
    t.integer "borrowers"
    t.date "lend_dates"
    t.date "return_dates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id"
    t.string "item_name"
    t.integer "amount"
    t.integer "owner_id"
    t.boolean "status"
    t.date "loan_date"
    t.date "expected_return_date"
    t.date "actual_return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_details", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.integer "lend_rating"
    t.integer "borrow_rating"
    t.string "item_list"
    t.string "available_items"
    t.string "friends"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
