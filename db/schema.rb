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

ActiveRecord::Schema.define(version: 20161104002323) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "dimension_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string   "code"
    t.integer  "question_id"
    t.integer  "questionnaire_id"
    t.string   "text"
    t.string   "notes"
    t.boolean  "positive",         default: false
    t.integer  "score"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "assessment_answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "assessment_id"
  end

  add_index "assessment_answers", ["answer_id"], name: "index_assessment_answers_on_answer_id"
  add_index "assessment_answers", ["assessment_id"], name: "index_assessment_answers_on_assessment_id"
  add_index "assessment_answers", ["question_id"], name: "index_assessment_answers_on_question_id"

  create_table "assessments", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "completion_date"
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "token"
  end

  add_index "assessments", ["user_id"], name: "index_assessments_on_user_id"

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true
  add_index "countries", ["name"], name: "index_countries_on_name", unique: true

  create_table "country_scores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dimensions", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "questionnaire_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "improvements", force: :cascade do |t|
    t.string   "code"
    t.integer  "answer_id"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "improvements", ["answer_id"], name: "index_improvements_on_answer_id"

  create_table "links", force: :cascade do |t|
    t.integer  "assessment_answer_id"
    t.string   "link"
    t.string   "text"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "links", ["assessment_answer_id"], name: "index_links_on_assessment_answer_id"

  create_table "organisation_scores", force: :cascade do |t|
    t.integer  "organisation_id"
    t.integer  "activity_id"
    t.integer  "initial"
    t.integer  "repeatable"
    t.integer  "defined"
    t.integer  "managed"
    t.integer  "optimising"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "dgu_id"
    t.integer  "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questionnaires", force: :cascade do |t|
    t.integer  "version"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questionnaires", ["version"], name: "index_questionnaires_on_version", unique: true

  create_table "questions", force: :cascade do |t|
    t.string   "code"
    t.integer  "activity_id"
    t.integer  "questionnaire_id"
    t.string   "text"
    t.string   "notes"
    t.integer  "dependency_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "assessment_id"
    t.integer  "activity_id"
    t.integer  "score"
    t.integer  "target"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.integer  "organisation_id"
    t.string   "name"
    t.integer  "country_id"
  end

  add_index "users", ["country_id"], name: "index_users_on_country_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
