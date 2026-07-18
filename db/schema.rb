# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_18_064215) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.text "ai_summary"
    t.bigint "company_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_conversations_on_company_id"
    t.index ["customer_id"], name: "index_conversations_on_customer_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
  end

  create_table "kpis", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.date "end_date"
    t.integer "period"
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_kpis_on_company_id"
    t.index ["user_id"], name: "index_kpis_on_user_id"
  end

  create_table "llm_configs", force: :cascade do |t|
    t.string "api_key"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "llm_model"
    t.string "provider"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_llm_configs_on_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.integer "status"
    t.decimal "total_amount"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "timeline_events", force: :cascade do |t|
    t.string "action"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.text "details"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_timeline_events_on_company_id"
    t.index ["customer_id"], name: "index_timeline_events_on_customer_id"
  end

  create_table "todos", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.boolean "is_completed"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_todos_on_company_id"
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "auth_token"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "conversations", "companies"
  add_foreign_key "conversations", "customers"
  add_foreign_key "conversations", "users"
  add_foreign_key "customers", "companies"
  add_foreign_key "kpis", "companies"
  add_foreign_key "kpis", "users"
  add_foreign_key "llm_configs", "companies"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "users"
  add_foreign_key "timeline_events", "companies"
  add_foreign_key "timeline_events", "customers"
  add_foreign_key "todos", "companies"
  add_foreign_key "todos", "users"
  add_foreign_key "users", "companies"
end
