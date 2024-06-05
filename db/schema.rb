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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_095113) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "start_location", null: false
    t.string "end_location", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_courses_on_plan_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_members_on_plan_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "planned_spots", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "position"
    t.index ["plan_id"], name: "index_planned_spots_on_plan_id"
    t.index ["spot_id"], name: "index_planned_spots_on_spot_id"
    t.index ["user_id"], name: "index_planned_spots_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id", null: false
    t.string "invitation_token"
    t.string "location", null: false
    t.index ["invitation_token"], name: "index_plans_on_invitation_token", unique: true
  end

  create_table "spot_points", force: :cascade do |t|
    t.integer "point", default: 0, null: false
    t.bigint "user_id", null: false
    t.bigint "planned_spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planned_spot_id"], name: "index_spot_points_on_planned_spot_id"
    t.index ["user_id"], name: "index_spot_points_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "opening_hours"
    t.string "phone_number"
    t.string "website"
    t.string "place_id"
    t.index ["place_id"], name: "index_spots_on_place_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "invited_plan_id"
    t.string "avatar"
    t.string "provider"
    t.string "uid"
    t.string "name", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "plans"
  add_foreign_key "members", "plans"
  add_foreign_key "members", "users"
  add_foreign_key "planned_spots", "plans"
  add_foreign_key "planned_spots", "spots"
  add_foreign_key "planned_spots", "users"
  add_foreign_key "plans", "users", column: "owner_id"
  add_foreign_key "spot_points", "planned_spots"
  add_foreign_key "spot_points", "users"
end
