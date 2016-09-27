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

ActiveRecord::Schema.define(version: 20160927122604) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "description",                 null: false
    t.boolean  "correct",     default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "answers_of_questions", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "submission_id"
    t.integer  "answer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "choice"
  end

  add_index "answers_of_questions", ["answer_id"], name: "index_answers_of_questions_on_answer_id"
  add_index "answers_of_questions", ["question_id"], name: "index_answers_of_questions_on_question_id"
  add_index "answers_of_questions", ["submission_id"], name: "index_answers_of_questions_on_submission_id"

  create_table "question_evaluations", force: :cascade do |t|
    t.integer "submission_id"
    t.integer "question_id"
    t.boolean "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "question_evaluations", ["question_id"], name: "index_question_evaluations_on_question_id"
  add_index "question_evaluations", ["submission_id"], name: "index_question_evaluations_on_submission_id"

  create_table "questions", force: :cascade do |t|
    t.text     "question_text",             null: false
    t.integer  "test_id"
    t.integer  "point",         default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "questions", ["test_id"], name: "index_questions_on_test_id"

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point", default: 0
    t.boolean "evaluated"
  end

  add_index "submissions", ["test_id"], name: "index_submissions_on_test_id"
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id"

  create_table "tests", force: :cascade do |t|
    t.integer  "User_id"
    t.string   "title",                    null: false
    t.text     "description", default: "", null: false
    t.integer  "length",                   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "public"
    t.boolean  "done"
    t.integer "point", default: 0
    t.string "token"
  end

  add_index "tests", ["User_id"], name: "index_tests_on_User_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
