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

ActiveRecord::Schema[7.0].define(version: 2022_04_11_165943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "places", force: :cascade do |t|
    t.integer "identificator"
    t.string "name"
    t.string "cre_identificator"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "last_regular", precision: 5, scale: 2
    t.decimal "last_premium", precision: 5, scale: 2
    t.decimal "last_diesel", precision: 5, scale: 2
    t.datetime "date_update"
    t.index ["latitude"], name: "index_places_on_latitude"
    t.index ["longitude"], name: "index_places_on_longitude"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "place_id"
    t.decimal "regular", precision: 5, scale: 2
    t.decimal "premium", precision: 5, scale: 2
    t.decimal "diesel", precision: 5, scale: 2
    t.datetime "date_add"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_prices_on_place_id"
  end

end
