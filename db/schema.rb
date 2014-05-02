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

ActiveRecord::Schema.define(version: 20140502001455) do

  create_table "account_configurations", force: true do |t|
    t.integer  "user_id"
    t.boolean  "allow_netting"
    t.integer  "collection_mail_frecuency_in_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "symbol"
    t.decimal  "fx_rate",    precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_profiles", force: true do |t|
    t.string   "bank_name"
    t.string   "account_number"
    t.string   "account_type"
    t.string   "rut"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "transactions", force: true do |t|
    t.integer  "debtor_id"
    t.integer  "lender_id"
    t.decimal  "amount",            precision: 10, scale: 0
    t.integer  "currency_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "settled_lender"
    t.boolean  "settled_debtor"
    t.boolean  "payment_requested"
    t.string   "token"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
