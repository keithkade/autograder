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

ActiveRecord::Schema.define(version: 20160421142119) do

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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "semester"
    t.integer  "year"
    t.boolean  "is_archived"
  end

  create_table "problem_test_cases", force: :cascade do |t|
    t.integer  "problemid"
    t.text     "input"
    t.text     "output"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "problems", force: :cascade do |t|
    t.string   "title"
    t.text     "skeleton"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "summary"
    t.text     "input_description"
    t.text     "output_description"
    t.text     "language"
    t.datetime "due_date"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.string   "qtype"
    t.integer  "qid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "time_limit"
    t.text     "questions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "courseid"
  end

  create_table "students", force: :cascade do |t|
    t.string   "ID"
    t.string   "UserName"
    t.string   "Password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "LastName"
    t.string   "FirstName"
    t.string   "Saves"
  end

  create_table "submissions", force: :cascade do |t|
    t.text     "code"
    t.text     "result"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "status"
    t.datetime "page_loaded_at"
    t.datetime "time_submitted"
    t.integer  "problem_id"
    t.integer  "student_id"
  end

end
