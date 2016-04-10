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

ActiveRecord::Schema.define(version: 20160410194720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_problem_relations", force: :cascade do |t|
    t.integer  "course"
    t.integer  "problem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_user_relations", force: :cascade do |t|
    t.integer  "course"
    t.integer  "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problem_test_cases", force: :cascade do |t|
    t.integer  "problemid"
    t.text     "input"
    t.text     "output"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.string   "title"
    t.text     "skeleton"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "summary"
    t.text     "input_description"
    t.text     "output_description"
  end

  create_table "students", force: :cascade do |t|
    t.string   "Name"
    t.string   "ID"
    t.string   "UserName"
    t.string   "Password"
    t.string   "Class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.string   "studentID"
    t.string   "problemID"
    t.text     "code"
    t.datetime "timeOnPage"
    t.text     "response"
    t.string   "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
