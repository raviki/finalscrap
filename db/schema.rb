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

ActiveRecord::Schema.define(version: 20131118050310) do

  create_table "activities", force: true do |t|
    t.text     "model"
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "belongsTo"
    t.text     "action_performed"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "city"
    t.integer  "pin"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "phone"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "product_id"
    t.decimal  "price",      precision: 10, scale: 0
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cart_id"
    t.string   "units"
  end

  create_table "carts", force: true do |t|
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  create_table "categories", force: true do |t|
    t.text     "name"
    t.string   "image"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_to_products", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_groups", force: true do |t|
    t.text     "description"
    t.integer  "permission_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_leads", force: true do |t|
    t.text     "type_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_managements", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.string   "mobile_number"
    t.integer  "customer_id"
    t.string   "remember_token"
    t.string   "password_digest"
    t.text     "provider"
    t.text     "uid"
    t.text     "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.decimal  "contact_no",             precision: 10, scale: 0
    t.text     "add_line1"
    t.text     "add_line2"
    t.text     "city"
    t.decimal  "pin",                    precision: 10, scale: 0
    t.boolean  "wishlist"
    t.integer  "customer_group_id"
    t.integer  "customer_lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "order_to_products", force: true do |t|
    t.integer  "order_id"
    t.integer  "store_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.decimal  "price",      precision: 10, scale: 0
  end

  create_table "orders", force: true do |t|
    t.integer  "customer_id"
    t.integer  "voucher_id"
    t.integer  "payment_id"
    t.decimal  "discount",         precision: 10, scale: 0
    t.text     "discount_message"
    t.time     "appointment_date"
    t.decimal  "duration_inHrs",   precision: 10, scale: 0
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  create_table "payments", force: true do |t|
    t.integer  "payment_method"
    t.decimal  "payment_amount", precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_to_tools", force: true do |t|
    t.integer  "product_id"
    t.integer  "tool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_variants", force: true do |t|
    t.integer  "product_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",      precision: 10, scale: 0
  end

  create_table "products", force: true do |t|
    t.text     "name"
    t.string   "image"
    t.text     "description"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.integer  "views"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video"
    t.text     "how2fix"
  end

  create_table "searches", force: true do |t|
    t.integer  "customer_id"
    t.text     "keys"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_to_products", force: true do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.decimal  "price",      precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", force: true do |t|
    t.string   "name"
    t.text     "contact_name"
    t.decimal  "contact_no",   precision: 10, scale: 0
    t.text     "address"
    t.decimal  "pin",          precision: 10, scale: 0
    t.text     "review"
    t.decimal  "rating",       precision: 10, scale: 0
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_to_tools", force: true do |t|
    t.integer  "task_id"
    t.integer  "tool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vouchers", force: true do |t|
    t.text     "description"
    t.integer  "customer_group_id"
    t.integer  "type_name"
    t.decimal  "value",             precision: 10, scale: 0
    t.date     "validity_till"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlists", force: true do |t|
    t.integer  "customer_id"
    t.integer  "store_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
