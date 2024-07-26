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

ActiveRecord::Schema[7.2].define(version: 2024_07_26_195204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.bigint "request_id", null: false
    t.bigint "vendor_id", null: false
    t.float "amount"
    t.datetime "work_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_bids_on_request_id"
    t.index ["vendor_id"], name: "index_bids_on_vendor_id"
  end

  create_table "cancellations", force: :cascade do |t|
    t.bigint "vendor_id"
    t.bigint "request_id", null: false
    t.datetime "reported"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_cancellations_on_request_id"
    t.index ["vendor_id"], name: "index_cancellations_on_vendor_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "outcome"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "request_services", force: :cascade do |t|
    t.bigint "request_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_request_services_on_request_id"
    t.index ["service_id"], name: "index_request_services_on_service_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "request_number"
    t.text "access_details"
    t.string "location"
    t.float "location_lat"
    t.float "location_long"
    t.datetime "scheduled"
    t.datetime "completed"
    t.text "completion_notes"
    t.integer "status"
    t.integer "request_type"
    t.bigint "customer_id"
    t.bigint "vendor_id"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_requests_on_customer_id"
    t.index ["vehicle_id"], name: "index_requests_on_vehicle_id"
    t.index ["vendor_id"], name: "index_requests_on_vendor_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.float "min_price"
    t.float "max_price"
    t.float "avg_price"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "timezone", default: "Eastern Time (US & Canada)", null: false
    t.string "phone_number"
    t.integer "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "nickname"
    t.string "make"
    t.string "model"
    t.string "color"
    t.string "license_plate"
    t.boolean "default"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "cancellations", "requests"
  add_foreign_key "payments", "users"
  add_foreign_key "request_services", "requests"
  add_foreign_key "request_services", "services"
  add_foreign_key "requests", "vehicles"
  add_foreign_key "vehicles", "users"
end
