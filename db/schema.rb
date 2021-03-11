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

ActiveRecord::Schema.define(version: 2021_03_11_170923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "x_parent"
    t.integer "num_children"
    t.boolean "inactive"
    t.string "organization"
    t.string "name"
    t.string "addr1"
    t.string "addr2"
    t.string "vaccines"
    t.string "logo"
    t.string "map_zoom"
    t.string "notes"
    t.string "notes_spn"
    t.string "alt"
    t.string "alt_spn"
    t.string "date"
    t.string "time"
    t.string "link"
    t.string "second_dose"
    t.string "full"
    t.string "comments"
    t.string "comments_spn"
    t.string "times"
    t.string "clinic_format"
    t.string "system"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addr1"], name: "index_locations_on_addr1"
  end

  create_table "processed_direct_messages", force: :cascade do |t|
    t.bigint "direct_message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["direct_message_id"], name: "index_processed_direct_messages_on_direct_message_id"
  end

  create_table "zip_subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["zip"], name: "index_zip_subscriptions_on_zip"
  end

end
