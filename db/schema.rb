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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120528063122) do

  create_table "attempted_questions", :id => false, :force => true do |t|
    t.integer  "question_id"
    t.integer  "player_id"
    t.boolean  "answered_correctly"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string "first_name",    :null => false
    t.string "last_name",     :null => false
    t.string "email",         :null => false
    t.string "mobile_number", :null => false
    t.string "city",          :null => false
    t.string "company_name",  :null => false
    t.string "role",          :null => false
  end

  create_table "questions", :force => true do |t|
    t.text   "question",           :limit => 255, :null => false
    t.string "correct_answer",                    :null => false
    t.string "incorrect_answer_1",                :null => false
    t.string "incorrect_answer_2",                :null => false
  end

  create_table "timers", :id => false, :force => true do |t|
    t.integer  "player_id"
    t.float    "time_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
