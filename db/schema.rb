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

ActiveRecord::Schema[7.2].define(version: 2024_07_19_144932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "customer_id", null: false
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
    t.float "price"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
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
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "request_services", "requests"
  add_foreign_key "request_services", "services"
  add_foreign_key "requests", "vehicles"
  add_foreign_key "vehicles", "users"
end
