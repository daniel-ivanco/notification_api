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

ActiveRecord::Schema.define(version: 2021_04_17_100551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_admin_users_on_uuid", unique: true
  end

  create_table "client_companies", force: :cascade do |t|
    t.float "weight", null: false
    t.integer "client_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "company_id"], name: "index_client_companies_on_client_id_and_company_id", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "name"
    t.float "portfolio_performance"
    t.datetime "portfolio_calculated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_clients_on_uuid", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.float "monthly_twr"
    t.datetime "twr_calculated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "deposits", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.bigserial "sequence_number", null: false
    t.bigint "xdr_sequence_number"
    t.text "payment_transaction_id"
    t.text "destination_address"
    t.float "amount"
    t.text "purpose"
    t.jsonb "payment_transaction_details"
    t.text "curv_transaction_id"
    t.integer "state", default: 0
    t.text "xdr"
    t.datetime "allocated_at"
    t.datetime "built_at"
    t.datetime "registered_at"
    t.datetime "approved_at"
    t.datetime "signed_at"
    t.datetime "pushed_at"
    t.datetime "scheduled_at"
    t.datetime "pending_at"
    t.datetime "mined_at"
    t.datetime "completed_at"
    t.datetime "aborted_at"
    t.datetime "rejected_at"
    t.datetime "failed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curv_transaction_id"], name: "index_deposits_on_curv_transaction_id", unique: true
    t.index ["payment_transaction_id"], name: "index_deposits_on_payment_transaction_id", unique: true
    t.index ["sequence_number"], name: "index_deposits_on_sequence_number", unique: true
    t.index ["state"], name: "index_deposits_on_state"
    t.index ["xdr"], name: "index_deposits_on_xdr"
  end

  create_table "withdrawals", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "stellar_memo_hash", limit: 64, default: -> { "concat(md5((random())::text), md5((random())::text))" }, null: false
    t.text "from"
    t.jsonb "to"
    t.float "amount"
    t.jsonb "metadata"
    t.integer "state", default: 0
    t.datetime "pending_at"
    t.datetime "successful_at"
    t.datetime "failed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stellar_memo_hash"], name: "index_withdrawals_on_stellar_memo_hash", unique: true
  end

end
