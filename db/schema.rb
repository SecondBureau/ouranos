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

ActiveRecord::Schema.define(:version => 20111019032951) do

  create_table "categories", :force => true do |t|
    t.string   "title",                           :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shows_at",    :default => "left"
  end

  create_table "categories_posts", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "post_id",     :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.text     "content",          :null => false
    t.integer  "user_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  create_table "events", :force => true do |t|
    t.string   "title",            :null => false
    t.text     "content",          :null => false
    t.date     "start_date",       :null => false
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "permalink"
  end

  create_table "member_confirms", :force => true do |t|
    t.integer  "user_id"
    t.date     "send_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "member_confirms", ["user_id"], :name => "index_member_confirms_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "title",            :null => false
    t.text     "content",          :null => false
    t.string   "permalink",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
    t.string   "meta_keywords"
    t.string   "meta_description"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                                :null => false
    t.text     "content",                              :null => false
    t.integer  "user_id",                              :null => false
    t.string   "permalink",                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_be_subscribed", :default => true
    t.string   "locale"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.boolean  "is_pinned",         :default => false
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribes", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.integer  "num_of_events"
    t.integer  "num_of_posts"
    t.integer  "cycle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscribes", ["user_id"], :name => "index_subscribes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",           :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",           :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role_id"
    t.string   "firstname",                             :default => "Firs tName", :null => false
    t.string   "lastname",                              :default => "Last Name",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expiry_date"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
