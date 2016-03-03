# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160303123154) do

  create_table "amenity_ceilings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenity_concierges", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenity_patios", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "building_amenities", force: :cascade do |t|
    t.integer  "building_id"
    t.boolean  "business_center"
    t.text     "business_center_"
    t.boolean  "resident_lounge"
    t.text     "resident_lounge_"
    t.boolean  "screening_room"
    t.text     "screening_room_"
    t.boolean  "rooftop_deck"
    t.text     "rooftop_deck_"
    t.boolean  "train_station"
    t.text     "train_station_"
    t.boolean  "pool"
    t.text     "pool_"
    t.boolean  "gated"
    t.text     "gated_"
    t.integer  "amenity_concierge_id"
    t.text     "concierge_"
    t.boolean  "recreation"
    t.text     "recreation_"
    t.boolean  "fitness"
    t.text     "fitness_"
    t.text     "other"
    t.boolean  "amenity_1"
    t.text     "amenity_1_"
    t.string   "amenity_1_name"
    t.boolean  "amenity_2"
    t.text     "amenity_2_"
    t.string   "amenity_2_name"
    t.boolean  "amenity_3"
    t.text     "amenity_3_"
    t.string   "amenity_3_name"
    t.integer  "amenity_11_id"
    t.text     "amenity_11_"
    t.string   "amenity_11_name"
    t.integer  "amenity_12_id"
    t.text     "amenity_12_"
    t.string   "amenity_12_name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "building_fee_schedules", force: :cascade do |t|
    t.integer  "building_id"
    t.float    "parking"
    t.text     "parking_"
    t.float    "parking_extra"
    t.text     "parking_extra_"
    t.float    "security_deposit"
    t.text     "security_deposit_"
    t.float    "amenity_fee"
    t.text     "amenity_fee_"
    t.float    "trash_fee"
    t.text     "trash_fee_"
    t.float    "pet_deposit"
    t.text     "pet_deposit_"
    t.float    "pet_dog"
    t.text     "pet_dog_"
    t.float    "pet_cat"
    t.text     "pet_cat_"
    t.float    "application_fee"
    t.text     "application_fee_"
    t.integer  "minimum_lease"
    t.text     "minimum_lease_"
    t.float    "monthly_fees"
    t.text     "monthly_fees_"
    t.float    "yearly_fees"
    t.text     "yearly_fees_"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "building_owners", force: :cascade do |t|
    t.integer  "building_id"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "building_unit_amenities", force: :cascade do |t|
    t.integer  "building_id"
    t.boolean  "washer_dryer"
    t.text     "washer_dryer_"
    t.boolean  "microwave"
    t.text     "microwave_"
    t.boolean  "security_alarm"
    t.text     "security_alarm_"
    t.integer  "amenity_ceiling_id"
    t.text     "ceiling_"
    t.integer  "amenity_patio_id"
    t.text     "patio_"
    t.boolean  "oversized_windows"
    t.text     "oversized_windows_"
    t.text     "other"
    t.text     "other_"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "building_units", force: :cascade do |t|
    t.string   "number"
    t.integer  "building_id"
    t.integer  "unit_type_id"
    t.integer  "sq_feet"
    t.text     "resident_name"
    t.float    "market_rent"
    t.float    "actual_rent"
    t.float    "resident_deposit"
    t.float    "other_deposit"
    t.date     "move_in"
    t.date     "move_out"
    t.date     "lease_expiration"
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "resident_id"
    t.integer  "floor"
    t.string   "bed_bath"
    t.integer  "beds"
    t.float    "baths"
    t.integer  "months_off"
    t.integer  "cash_off"
    t.integer  "lease_length"
  end

  create_table "buildings", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "comp_group_id"
    t.text     "phone"
    t.text     "manager"
    t.integer  "number_of_units"
    t.text     "website"
    t.integer  "year_built"
    t.integer  "year_remodeled"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "owner_id"
    t.integer  "geography_id"
    t.boolean  "competitor"
    t.text     "manager_email"
    t.text     "manager_phone"
  end

  create_table "comp_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geographies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.boolean  "competitor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "unit_types", force: :cascade do |t|
    t.text     "description"
    t.integer  "beds"
    t.integer  "baths"
    t.integer  "sq_ft_low"
    t.integer  "sq_ft_high"
    t.integer  "floor_low"
    t.integer  "floor_high"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_geographies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "geography_id"
    t.string   "access_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "owner_id"
    t.boolean  "approved"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "super_admin"
    t.boolean  "owner_admin"
    t.boolean  "pm_admin"
  end

end
