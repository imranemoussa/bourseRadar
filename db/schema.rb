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

ActiveRecord::Schema[8.0].define(version: 2025_07_02_191438) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

  create_table "institutions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "description"
    t.string "country"
    t.string "city"
    t.string "website"
    t.string "contact_email"
    t.string "contact_phone"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_institutions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "message"
    t.string "notification_type", null: false
    t.boolean "read", default: false
    t.json "data", default: {}
    t.bigint "scholarship_id", null: false
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scholarship_id"], name: "index_notifications_on_scholarship_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "scholarships", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.string "title"
    t.text "description"
    t.text "requirements"
    t.text "benefits"
    t.string "level"
    t.string "field_of_study"
    t.string "country"
    t.string "city"
    t.decimal "pourcentage", precision: 5, scale: 2
    t.string "scholarship_type"
    t.integer "duration_months"
    t.date "application_deadline"
    t.date "program_start_date"
    t.string "language"
    t.integer "age_min"
    t.integer "age_max"
    t.string "gender_requirement"
    t.string "external_application_url"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_scholarships_on_institution_id"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "birth_date"
    t.string "nationality"
    t.string "current_level"
    t.string "current_institution"
    t.string "field_of_study"
    t.text "bio"
    t.string "address"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_student_profiles_on_country"
    t.index ["current_level"], name: "index_student_profiles_on_current_level"
    t.index ["field_of_study"], name: "index_student_profiles_on_field_of_study"
    t.index ["nationality"], name: "index_student_profiles_on_nationality"
    t.index ["user_id"], name: "index_student_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "role", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "institutions", "users"
  add_foreign_key "notifications", "scholarships"
  add_foreign_key "notifications", "users"
  add_foreign_key "scholarships", "institutions"
  add_foreign_key "student_profiles", "users"
end
