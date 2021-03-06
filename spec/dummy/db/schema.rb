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

ActiveRecord::Schema.define(version: 20190529041743) do

  create_table "larvata_timesheet_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "category_id"
    t.integer "rank", null: false
    t.string "name", null: false
    t.boolean "enabled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_larvata_timesheet_activities_on_category_id"
  end

  create_table "larvata_timesheet_calendar_months", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "date_id", null: false
    t.boolean "enabled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date_id"], name: "index_larvata_timesheet_calendar_months_on_date_id", unique: true
  end

  create_table "larvata_timesheet_calendars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name"
    t.boolean "default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_larvata_timesheet_calendars_on_name", unique: true
  end

  create_table "larvata_timesheet_offdays", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "date_id", null: false
    t.boolean "is_off", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "larvata_timesheet_calendar_id"
    t.index ["date_id"], name: "index_larvata_timesheet_offdays_on_date_id", unique: true
    t.index ["larvata_timesheet_calendar_id"], name: "index_larvata_timesheet_offdays_on_larvata_timesheet_calendar_id"
  end

  add_foreign_key "larvata_timesheet_activities", "larvata_timesheet_activities", column: "category_id"
  add_foreign_key "larvata_timesheet_offdays", "larvata_timesheet_calendars"
end
