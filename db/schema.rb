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

ActiveRecord::Schema.define(version: 20150819210813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributes", force: :cascade do |t|
    t.string  "name"
    t.integer "project_id"
  end

  create_table "capabilities", force: :cascade do |t|
    t.string  "name"
    t.integer "project_id"
    t.integer "result_id"
    t.string  "code"
    t.string  "url"
    t.string  "oauth"
    t.boolean "last_result"
    t.integer "last_failure"
  end

  create_table "capability_maps", force: :cascade do |t|
    t.integer "project_id"
    t.integer "attribute_id"
    t.integer "component_id"
    t.integer "capability_id"
  end

  create_table "components", force: :cascade do |t|
    t.string  "name"
    t.integer "project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
  end

  create_table "results", force: :cascade do |t|
    t.integer  "capability_id"
    t.integer  "project_id"
    t.integer  "time"
    t.boolean  "result"
  end

end
