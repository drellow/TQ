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

ActiveRecord::Schema.define(:version => 20130514043651) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "body"
    t.integer  "score",       :default => 25
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.text     "body",       :limit => 255
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "feed_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "scope"
    t.string   "path"
    t.string   "body"
    t.boolean  "read",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "notifiers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "body"
    t.text     "info"
    t.integer  "user_id"
    t.boolean  "posted_answers"
    t.boolean  "emailed_answers"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "hero_id"
    t.integer  "fan_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "suggestions", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "score",      :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "archived",   :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "color",                  :default => "#B1ABAB"
    t.string   "provider"
    t.string   "access_token"
    t.string   "uid"
    t.boolean  "admin"
    t.boolean  "receives_email",         :default => true
    t.string   "title",                  :default => "The New One"
    t.integer  "score",                  :default => 100
    t.integer  "legacy_score",           :default => 100
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "email",                  :default => "",            :null => false
    t.string   "encrypted_password",     :default => "",            :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
