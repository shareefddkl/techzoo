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

ActiveRecord::Schema.define(:version => 20120328093701) do

  create_table "adminos", :force => true do |t|
    t.string   "email",                    :limit => 100
    t.string   "hashed_password",          :limit => 100
    t.string   "salt",                     :limit => 100
    t.string   "activation_code",          :limit => 100
    t.datetime "activated_at"
    t.string   "employee_code",            :limit => 20
    t.string   "user_type",                :limit => 20
    t.string   "account_id",               :limit => 100
    t.string   "email_encrypted",          :limit => 100
    t.string   "reset_password_code",      :limit => 100
    t.date     "last_password_reseted_at"
    t.string   "role",                     :limit => 20
    t.string   "status",                   :limit => 20
    t.date     "last_logged_in_at"
    t.integer  "login_failed_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "active_all"
    t.boolean  "active"
    t.string   "title"
    t.text     "matter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chats", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "reciever_id"
    t.string   "text",        :limit => 1000
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments_videos", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "video_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",           :limit => 50
    t.text     "abstract"
    t.text     "prerequisites"
    t.text     "course_content"
    t.string   "language",       :limit => 50
    t.string   "duration",       :limit => 30
    t.string   "categories"
    t.integer  "strength"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "course_type",    :limit => 30
    t.string   "status",         :limit => 20
    t.string   "amount"
    t.string   "course_fee"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mentor_id"
  end

  create_table "courses_students", :force => true do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "document_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_upload_at"
    t.integer  "course_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.text     "comment"
    t.float    "communication_skills"
    t.float    "teaching_skill"
    t.float    "course_material"
    t.float    "doubt_clearence"
    t.float    "subject_knowledge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imported_contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email",      :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", :force => true do |t|
    t.integer  "user_id"
    t.string   "emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentors", :force => true do |t|
    t.string   "user_id"
    t.string   "first_name",        :limit => 100
    t.string   "middle_name",       :limit => 100
    t.string   "last_name",         :limit => 100
    t.date     "date_of_birth"
    t.text     "address"
    t.string   "city",              :limit => 50
    t.string   "state",             :limit => 50
    t.string   "country",           :limit => 30
    t.integer  "pincode"
    t.integer  "lande_line_no"
    t.string   "mobile",            :limit => 15
    t.string   "college_name",      :limit => 50
    t.string   "standard"
    t.string   "board",             :limit => 100
    t.string   "university"
    t.string   "degree",            :limit => 50
    t.string   "stream",            :limit => 50
    t.string   "designation",       :limit => 50
    t.string   "qualification",     :limit => 50
    t.string   "corexp"
    t.string   "education"
    t.string   "occupation"
    t.string   "work"
    t.string   "location"
    t.string   "education_type",    :limit => 15
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "technical"
    t.string   "nontechnical"
    t.string   "employer"
    t.string   "working"
    t.string   "more_work_details"
    t.string   "research_paper"
    t.string   "research_work"
    t.string   "misc"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.text     "body"
    t.string   "user_status",     :limit => 10
    t.string   "receiver_status", :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "content_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "user_id"
    t.string   "first_name",        :limit => 40
    t.string   "middle_name",       :limit => 40
    t.string   "last_name",         :limit => 40
    t.date     "date_of_birth"
    t.text     "address"
    t.string   "city",              :limit => 20
    t.string   "state",             :limit => 30
    t.string   "country",           :limit => 40
    t.integer  "pincode"
    t.integer  "land_line_no"
    t.string   "mobile"
    t.string   "college_name",      :limit => 40
    t.string   "standard",          :limit => 30
    t.string   "university",        :limit => 40
    t.string   "degree",            :limit => 20
    t.string   "stream",            :limit => 30
    t.string   "company",           :limit => 40
    t.string   "designation",       :limit => 40
    t.string   "qualification",     :limit => 30
    t.string   "education_type",    :limit => 15
    t.string   "education"
    t.string   "occupation"
    t.string   "working_domain"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "working"
    t.string   "more_work_details"
    t.string   "research_paper"
    t.string   "research_work"
    t.string   "misc"
    t.string   "technical",         :limit => 1000
    t.string   "nontechnical",      :limit => 1000
    t.string   "employer"
    t.string   "title"
  end

  create_table "suggestions", :force => true do |t|
    t.string   "email"
    t.string   "subject"
    t.string   "suggestion_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                    :limit => 100
    t.string   "hashed_password",          :limit => 100
    t.string   "salt",                     :limit => 100
    t.string   "activation_code",          :limit => 100
    t.datetime "activated_at"
    t.string   "user_type",                :limit => 20
    t.string   "account_id",               :limit => 100
    t.string   "email_encrypted",          :limit => 100
    t.string   "reset_password_code",      :limit => 100
    t.date     "last_password_reseted_at"
    t.string   "role",                     :limit => 20
    t.string   "status",                   :limit => 20
    t.date     "last_logged_in_at"
    t.integer  "login_failed_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_online",                               :default => false
    t.datetime "last_accessed_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "notify_via_email"
    t.boolean  "notify_on_new_articles"
    t.boolean  "notify_on_comments"
    t.integer  "profile_id",                              :default => 1
    t.string   "text_filter_id",                          :default => "1"
    t.text     "settings"
    t.string   "login",                                   :default => "admin"
    t.string   "name",                                    :default => "admin"
    t.datetime "last_connection"
    t.string   "every_new_course",         :limit => 15
    t.string   "course_related",           :limit => 40
    t.string   "categories_type",          :limit => 15
    t.string   "course_accept_reject",     :limit => 15
  end

  create_table "videos", :force => true do |t|
    t.string   "title",              :limit => 20
    t.string   "video_file_name",    :limit => 40
    t.datetime "video_upload_at"
    t.integer  "video_file_size"
    t.string   "video_content_type"
    t.string   "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
