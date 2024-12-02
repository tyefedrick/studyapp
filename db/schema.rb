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

ActiveRecord::Schema[8.0].define(version: 2024_12_02_154752) do
  create_table "answer_options", force: :cascade do |t|
    t.integer "question_id", null: false
    t.text "content"
    t.boolean "correct"
    t.integer "matching_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answer_options_on_question_id"
  end

  create_table "flashcard_sets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "visibility"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_flashcard_sets_on_user_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.integer "flashcard_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flashcard_set_id"], name: "index_flashcards_on_flashcard_set_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "test_set_id", null: false
    t.text "content"
    t.text "explanation"
    t.integer "question_type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_set_id"], name: "index_questions_on_test_set_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "test_sets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id", null: false
    t.boolean "show_score_as_you_go"
    t.boolean "show_explanation"
    t.boolean "show_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_test_sets_on_user_id"
  end

  create_table "user_responses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.integer "correct_recent_attempts"
    t.integer "incorrect_recent_attempts"
    t.integer "correct_all_time_attempts"
    t.integer "incorrect_all_time_attempts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "selected_answer"
    t.integer "test_set_id", null: false
    t.boolean "correct"
    t.string "test_session"
    t.index ["question_id"], name: "index_user_responses_on_question_id"
    t.index ["test_set_id"], name: "index_user_responses_on_test_set_id"
    t.index ["user_id"], name: "index_user_responses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.boolean "admin"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "answer_options", "questions"
  add_foreign_key "flashcard_sets", "users"
  add_foreign_key "flashcards", "flashcard_sets"
  add_foreign_key "questions", "test_sets"
  add_foreign_key "sessions", "users"
  add_foreign_key "test_sets", "users"
  add_foreign_key "user_responses", "questions"
  add_foreign_key "user_responses", "test_sets"
  add_foreign_key "user_responses", "users"
end
