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

ActiveRecord::Schema.define(version: 2021_07_29_030022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendee_notes", force: :cascade do |t|
    t.text "note"
    t.string "note_type"
    t.bigint "attendee_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attendee_id"], name: "index_attendee_notes_on_attendee_id"
    t.index ["user_id"], name: "index_attendee_notes_on_user_id"
  end

  create_table "attendees", force: :cascade do |t|
    t.integer "event_id"
    t.string "event_name"
    t.integer "neon_attendee_id"
    t.boolean "guest_badge"
    t.string "badge_name"
    t.string "emergency_contact"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "email"
    t.string "legal_name"
    t.string "preferred_first_name"
    t.string "preferred_last_name"
    t.string "membership_type"
    t.string "area_code"
    t.string "phone_number"
    t.integer "registrant_id"
    t.string "registrant_legal_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "aasm_state"
    t.datetime "checked_in_at"
    t.bigint "checked_in_by"
    t.datetime "reissued_once_at"
    t.bigint "reissued_once_by"
    t.datetime "reissued_twice_at"
    t.bigint "reissued_twice_by"
    t.datetime "reissued_thrice_at"
    t.bigint "reissued_thrice_by"
    t.datetime "last_chance_at"
    t.bigint "last_chance_by"
    t.datetime "ejected_at"
    t.bigint "ejected_by"
    t.string "reissued_twice_pay_type"
    t.string "reissued_thrice_pay_type"
    t.string "last_chance_pay_type"
    t.integer "transaction_id"
    t.datetime "registered_at"
    t.index ["badge_name"], name: "index_attendees_on_badge_name"
    t.index ["event_id"], name: "index_attendees_on_event_id"
    t.index ["neon_attendee_id"], name: "index_attendees_on_neon_attendee_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.string "{:null=>false}"
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "attendee_notes", "attendees"
  add_foreign_key "attendee_notes", "users"
end
