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

ActiveRecord::Schema.define(:version => 20101017205410) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "report_email"
    t.integer  "secret_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_logo"
  end

  create_table "orders", :force => true do |t|
    t.integer  "purchaser_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.string   "ip_address"
    t.string   "number"
    t.string   "transaction_id"
    t.datetime "date_paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paypal_token"
  end

  add_index "orders", ["number"], :name => "index_orders_on_number"
  add_index "orders", ["paypal_token"], :name => "index_orders_on_paypal_token"
  add_index "orders", ["purchaser_id"], :name => "index_orders_on_purchaser_id"
  add_index "orders", ["transaction_id"], :name => "index_orders_on_transaction_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "pints", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "redemption_date"
    t.integer  "purchaser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "screen_name"
    t.string   "secret"
    t.integer  "purchased_count", :default => 0
    t.integer  "pints_count",     :default => 0
  end

end
