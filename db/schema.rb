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

ActiveRecord::Schema.define(:version => 20130701024731) do

  create_table "published_surveys", :force => true do |t|
    t.integer  "survey_id",  :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title",      :default => "", :null => false
    t.integer  "score",      :default => 0,  :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "survey_participants", :force => true do |t|
    t.string   "firstname",           :null => false
    t.string   "lastname",            :null => false
    t.string   "email",               :null => false
    t.integer  "published_survey_id", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "question_ids", :default => ""
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end
