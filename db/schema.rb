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

ActiveRecord::Schema[8.1].define(version: 2026_09_03_024060) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "company", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.bigint "organization_id", null: false
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "company"], name: "index_customers_on_organization_id_and_company"
    t.index ["organization_id", "email"], name: "index_customers_on_organization_id_and_email", unique: true
    t.index ["organization_id"], name: "index_customers_on_organization_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "amount_cents", null: false
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.datetime "issued_at", null: false
    t.bigint "organization_id", null: false
    t.datetime "paid_at"
    t.string "status", null: false
    t.bigint "subscription_id"
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["organization_id", "customer_id", "issued_at"], name: "idx_on_organization_id_customer_id_issued_at_571c173716"
    t.index ["organization_id"], name: "index_invoices_on_organization_id"
    t.index ["subscription_id"], name: "index_invoices_on_subscription_id"
  end

  create_table "knowledge_documents", force: :cascade do |t|
    t.text "body", null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.bigint "organization_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "category"], name: "index_knowledge_documents_on_organization_id_and_category"
    t.index ["organization_id"], name: "index_knowledge_documents_on_organization_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "organization_id", null: false
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["organization_id", "user_id"], name: "index_memberships_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "canceled_at"
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.integer "monthly_price_cents", null: false
    t.bigint "organization_id", null: false
    t.string "plan_name", null: false
    t.datetime "renewal_at", null: false
    t.datetime "started_at", null: false
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["organization_id", "customer_id"], name: "index_subscriptions_on_organization_id_and_customer_id"
    t.index ["organization_id"], name: "index_subscriptions_on_organization_id"
  end

  create_table "support_cases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.text "description", null: false
    t.datetime "opened_at", null: false
    t.bigint "organization_id", null: false
    t.string "priority", null: false
    t.datetime "resolved_at"
    t.string "status", null: false
    t.string "subject", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_support_cases_on_customer_id"
    t.index ["organization_id", "customer_id", "status"], name: "idx_on_organization_id_customer_id_status_fc4276537e"
    t.index ["organization_id"], name: "index_support_cases_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "customers", "organizations"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "organizations"
  add_foreign_key "invoices", "subscriptions"
  add_foreign_key "knowledge_documents", "organizations"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "organizations"
  add_foreign_key "support_cases", "customers"
  add_foreign_key "support_cases", "organizations"
end
