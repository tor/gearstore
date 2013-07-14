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

ActiveRecord::Schema.define(:version => 20130714232139) do

  create_table "access", :primary_key => "aid", :force => true do |t|
    t.string  "mask",                :default => "", :null => false
    t.string  "type",                :default => "", :null => false
    t.integer "status", :limit => 1, :default => 0,  :null => false
  end

  create_table "account_records", :primary_key => "tid", :force => true do |t|
    t.date    "transaction_date",               :null => false
    t.string  "description",      :limit => 50, :null => false
    t.integer "amount",                         :null => false
    t.integer "balance",                        :null => false
    t.integer "member_form"
    t.string  "comments",         :limit => 50
  end

  create_table "anu_student", :primary_key => "student_number", :force => true do |t|
    t.string  "last_name",    :limit => 100, :default => "", :null => false
    t.string  "given_name",   :limit => 100, :default => "", :null => false
    t.integer "is_student",                                  :null => false
    t.integer "is_postgrad",                                 :null => false
    t.integer "is_undergrad",                                :null => false
    t.integer "is_full_time",                                :null => false
    t.integer "retrieved",                                   :null => false
  end

  create_table "authmap", :primary_key => "aid", :force => true do |t|
    t.integer "uid",                     :default => 0,  :null => false
    t.string  "authname", :limit => 128, :default => "", :null => false
    t.string  "module",   :limit => 128, :default => "", :null => false
  end

  add_index "authmap", ["authname"], :name => "authname", :unique => true

  create_table "bio", :id => false, :force => true do |t|
    t.integer "nid", :default => 0, :null => false
    t.integer "uid", :default => 0, :null => false
  end

  create_table "blocks", :id => false, :force => true do |t|
    t.string  "module",     :limit => 64, :default => "",     :null => false
    t.string  "delta",      :limit => 32, :default => "0",    :null => false
    t.string  "theme",                    :default => "",     :null => false
    t.integer "status",     :limit => 1,  :default => 0,      :null => false
    t.integer "weight",     :limit => 1,  :default => 0,      :null => false
    t.string  "region",     :limit => 64, :default => "left", :null => false
    t.integer "custom",     :limit => 1,  :default => 0,      :null => false
    t.integer "throttle",   :limit => 1,  :default => 0,      :null => false
    t.integer "visibility", :limit => 1,  :default => 0,      :null => false
    t.text    "pages",                                        :null => false
    t.string  "title",      :limit => 64, :default => "",     :null => false
  end

  create_table "blocks_roles", :id => false, :force => true do |t|
    t.string  "module", :limit => 64, :null => false
    t.string  "delta",  :limit => 32, :null => false
    t.integer "rid",                  :null => false
  end

  create_table "boxes", :primary_key => "bid", :force => true do |t|
    t.text    "body",   :limit => 2147483647
    t.string  "info",   :limit => 128,        :default => "", :null => false
    t.integer "format",                       :default => 0,  :null => false
  end

  add_index "boxes", ["info"], :name => "info", :unique => true

  create_table "cache", :primary_key => "cid", :force => true do |t|
    t.binary  "data",    :limit => 2147483647
    t.integer "expire",                        :default => 0, :null => false
    t.integer "created",                       :default => 0, :null => false
    t.text    "headers"
  end

  add_index "cache", ["expire"], :name => "expire"

  create_table "cache_content", :primary_key => "cid", :force => true do |t|
    t.binary  "data",    :limit => 2147483647
    t.integer "expire",                        :default => 0, :null => false
    t.integer "created",                       :default => 0, :null => false
    t.text    "headers"
  end

  add_index "cache_content", ["expire"], :name => "expire"

  create_table "cache_filter", :primary_key => "cid", :force => true do |t|
    t.binary  "data",    :limit => 2147483647
    t.integer "expire",                        :default => 0, :null => false
    t.integer "created",                       :default => 0, :null => false
    t.text    "headers"
  end

  add_index "cache_filter", ["expire"], :name => "expire"

  create_table "cache_menu", :primary_key => "cid", :force => true do |t|
    t.binary  "data",    :limit => 2147483647
    t.integer "expire",                        :default => 0, :null => false
    t.integer "created",                       :default => 0, :null => false
    t.text    "headers"
  end

  add_index "cache_menu", ["expire"], :name => "expire"

  create_table "cache_page", :primary_key => "cid", :force => true do |t|
    t.binary  "data",    :limit => 2147483647
    t.integer "expire",                        :default => 0, :null => false
    t.integer "created",                       :default => 0, :null => false
    t.text    "headers"
  end

  add_index "cache_page", ["expire"], :name => "expire"

  create_table "cache_views", :primary_key => "cid", :force => true do |t|
    t.binary  "data",    :limit => 2147483647
    t.integer "expire",                        :default => 0, :null => false
    t.integer "created",                       :default => 0, :null => false
    t.text    "headers"
  end

  add_index "cache_views", ["expire"], :name => "expire"

  create_table "captcha_points", :primary_key => "form_id", :force => true do |t|
    t.string "module", :limit => 64
    t.string "type",   :limit => 64
  end

  create_table "comments", :primary_key => "cid", :force => true do |t|
    t.integer "pid",                             :default => 0,  :null => false
    t.integer "nid",                             :default => 0,  :null => false
    t.integer "uid",                             :default => 0,  :null => false
    t.string  "subject",   :limit => 64,         :default => "", :null => false
    t.text    "comment",   :limit => 2147483647,                 :null => false
    t.string  "hostname",  :limit => 128,        :default => "", :null => false
    t.integer "timestamp",                       :default => 0,  :null => false
    t.integer "score",     :limit => 3,          :default => 0,  :null => false
    t.integer "status",    :limit => 1,          :default => 0,  :null => false
    t.integer "format",                          :default => 0,  :null => false
    t.string  "thread",                                          :null => false
    t.text    "users",     :limit => 2147483647
    t.string  "name",      :limit => 60
    t.string  "mail",      :limit => 64
    t.string  "homepage"
  end

  add_index "comments", ["nid"], :name => "lid"

  create_table "contact", :primary_key => "cid", :force => true do |t|
    t.string  "category",                         :default => "", :null => false
    t.text    "recipients", :limit => 2147483647,                 :null => false
    t.text    "reply",      :limit => 2147483647,                 :null => false
    t.integer "weight",     :limit => 1,          :default => 0,  :null => false
    t.integer "selected",   :limit => 1,          :default => 0,  :null => false
  end

  add_index "contact", ["category"], :name => "category", :unique => true

  create_table "contemplate", :id => false, :force => true do |t|
    t.string  "type",      :limit => 32,  :default => "", :null => false
    t.text    "teaser",                                   :null => false
    t.text    "body",                                     :null => false
    t.text    "rss",                                      :null => false
    t.string  "enclosure", :limit => 128,                 :null => false
    t.integer "flags",                    :default => 7,  :null => false
  end

  add_index "contemplate", ["type"], :name => "type"

  create_table "contemplate_files", :id => false, :force => true do |t|
    t.string "site",                       :null => false
    t.binary "data", :limit => 2147483647, :null => false
  end

  add_index "contemplate_files", ["site"], :name => "site", :unique => true

  create_table "content_field_contact", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                       :default => 0, :null => false
    t.text    "field_contact_value", :limit => 2147483647
  end

  create_table "content_field_costs", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                     :default => 0, :null => false
    t.text    "field_costs_value", :limit => 2147483647
  end

  create_table "content_field_difficulty", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                 :default => 0,  :null => false
    t.string  "field_difficulty_value", :limit => 1, :default => "", :null => false
  end

  create_table "content_field_first_time_friendly", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                             :default => 0, :null => false
    t.integer "field_first_time_friendly_value"
  end

  create_table "content_field_pretrip_date", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                    :default => 0, :null => false
    t.string  "field_pretrip_date_value", :limit => 20
  end

  create_table "content_field_pretrip_location", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                                :default => 0, :null => false
    t.text    "field_pretrip_location_value", :limit => 2147483647
  end

  create_table "content_field_safety_contact_address", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                                      :default => 0, :null => false
    t.text    "field_safety_contact_address_value", :limit => 2147483647
  end

  create_table "content_field_safety_contact_number", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                                     :default => 0, :null => false
    t.text    "field_safety_contact_number_value", :limit => 2147483647
  end

  create_table "content_field_safety_details", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                              :default => 0, :null => false
    t.text    "field_safety_details_value", :limit => 2147483647
  end

  create_table "content_field_safety_person", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                             :default => 0, :null => false
    t.text    "field_safety_person_value", :limit => 2147483647
  end

  create_table "content_field_safety_warning_date", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                           :default => 0, :null => false
    t.string  "field_safety_warning_date_value", :limit => 20
  end

  create_table "content_field_terrain", :id => false, :force => true do |t|
    t.integer "vid",                               :default => 0,  :null => false
    t.integer "delta",                             :default => 0,  :null => false
    t.integer "nid",                               :default => 0,  :null => false
    t.string  "field_terrain_value", :limit => 10, :default => "", :null => false
  end

  create_table "content_type_administrative_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_belay_course", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_belay_course_wl", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_bushwalking_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                :default => 0,  :null => false
    t.string  "field_distance_value", :limit => 10, :default => "", :null => false
  end

  create_table "content_type_canyoning_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_climbing_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_event", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_for_sale", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                               :default => 0, :null => false
    t.text    "field_contact_details_value", :limit => 2147483647
    t.integer "field_archived_0_value"
  end

  create_table "content_type_general_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_inland_kayaking_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_mountain_biking_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_mountaineering_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_multi_activity_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_news", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_orienteering_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_page", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_road_cycling_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_rogaining_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_sea_kayaking_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_skiing_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_snowshoeing_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_social_trip", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_story", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_trip_idea", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                  :default => 0, :null => false
    t.integer "field_archived_value"
  end

  create_table "content_type_trip_report", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
  end

  create_table "content_type_uprofile", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                                        :default => 0,  :null => false
    t.text    "field_first_name_value",               :limit => 2147483647
    t.text    "field_last_name_value",                :limit => 2147483647
    t.text    "field_first_aid_qualifications_value", :limit => 2147483647
    t.integer "field_medical_conditions_value"
    t.text    "field_nok_full_name_value",            :limit => 2147483647
    t.string  "field_nok_phone_value",                :limit => 20,         :default => "", :null => false
    t.text    "field_nok_address_value",              :limit => 2147483647
    t.string  "field_gender_value",                   :limit => 1,          :default => "", :null => false
    t.text    "field_address_value",                  :limit => 2147483647
    t.integer "field_anu_student_value"
    t.string  "field_mobile_phone_value",             :limit => 15,         :default => "", :null => false
    t.string  "field_home_phone_value",               :limit => 15,         :default => "", :null => false
    t.string  "field_work_phone_value",               :limit => 15,         :default => "", :null => false
    t.text    "field_vehicle_make_model_value",       :limit => 2147483647
    t.integer "field_vehicle_all_parks_pass_value"
    t.string  "field_vehicle_registration_value",     :limit => 15,         :default => "", :null => false
    t.text    "field_vehicle_num_seats_value",        :limit => 2147483647
    t.integer "field_stu_sra_number_value"
  end

  create_table "event", :primary_key => "nid", :force => true do |t|
    t.integer "event_start", :default => 0, :null => false
    t.integer "event_end",   :default => 0, :null => false
    t.integer "timezone",    :default => 0, :null => false
  end

  add_index "event", ["event_start"], :name => "event_start"

  create_table "file_revisions", :id => false, :force => true do |t|
    t.integer "fid",                      :default => 0,  :null => false
    t.integer "vid",                      :default => 0,  :null => false
    t.string  "description",              :default => "", :null => false
    t.integer "list",        :limit => 1, :default => 0,  :null => false
  end

  add_index "file_revisions", ["vid"], :name => "vid"

  create_table "files", :primary_key => "fid", :force => true do |t|
    t.integer "nid",      :default => 0,  :null => false
    t.string  "filename", :default => "", :null => false
    t.string  "filepath", :default => "", :null => false
    t.string  "filemime", :default => "", :null => false
    t.integer "filesize", :default => 0,  :null => false
  end

  add_index "files", ["nid"], :name => "nid"

  create_table "filter_formats", :primary_key => "format", :force => true do |t|
    t.string  "name",               :default => "", :null => false
    t.string  "roles",              :default => "", :null => false
    t.integer "cache", :limit => 1, :default => 0,  :null => false
  end

  add_index "filter_formats", ["name"], :name => "name", :unique => true

  create_table "filters", :id => false, :force => true do |t|
    t.integer "format",               :default => 0,  :null => false
    t.string  "module", :limit => 64, :default => "", :null => false
    t.integer "delta",  :limit => 1,  :default => 0,  :null => false
    t.integer "weight", :limit => 1,  :default => 0,  :null => false
  end

  add_index "filters", ["weight"], :name => "weight"

  create_table "flood", :id => false, :force => true do |t|
    t.string  "event",     :limit => 64,  :default => "", :null => false
    t.string  "hostname",  :limit => 128, :default => "", :null => false
    t.integer "timestamp",                :default => 0,  :null => false
  end

  create_table "forum", :primary_key => "vid", :force => true do |t|
    t.integer "nid", :default => 0, :null => false
    t.integer "tid", :default => 0, :null => false
  end

  add_index "forum", ["nid"], :name => "nid"
  add_index "forum", ["tid"], :name => "tid"

  create_table "gear_items", :force => true do |t|
    t.integer  "gear_type_id"
    t.string   "identifier"
    t.string   "description"
    t.datetime "retired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gear_types", :force => true do |t|
    t.string   "name"
    t.decimal  "fee",        :precision => 10, :scale => 0
    t.decimal  "deposit",    :precision => 10, :scale => 0
    t.boolean  "anonymous"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gs3_deposits", :force => true do |t|
    t.integer  "amount",     :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "gs3_gear_item_notes", :force => true do |t|
    t.integer  "rental_item_id"
    t.integer  "approver_id"
    t.integer  "gear_item_id"
    t.string   "note"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "gs3_gear_item_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "private_hire",    :default => 0
    t.integer  "private_deposit", :default => 0
    t.integer  "club_hire",       :default => 0
    t.integer  "club_deposit",    :default => 0
    t.string   "sort_type",       :default => "alpha"
    t.boolean  "deleted",         :default => false
  end

  create_table "gs3_gear_items", :force => true do |t|
    t.integer  "gear_item_type_id"
    t.string   "identifier"
    t.string   "description"
    t.string   "size"
    t.string   "value"
    t.string   "condition"
    t.integer  "year_purchased"
    t.boolean  "missing",           :default => false
    t.boolean  "rented",            :default => false
    t.string   "comment"
    t.datetime "retired"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "broken",            :default => false
  end

  create_table "gs3_ledgers", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "amount"
    t.integer  "approver_id"
    t.integer  "rental_id"
    t.integer  "user_id"
    t.string   "description"
  end

  create_table "gs3_rental_items", :force => true do |t|
    t.integer  "rental_id"
    t.integer  "gear_item_id"
    t.integer  "return_approver_id"
    t.string   "return_note"
    t.datetime "returned_on"
    t.boolean  "missing"
    t.integer  "fee"
    t.integer  "deposit"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "gs3_rentals", :force => true do |t|
    t.integer  "user_id"
    t.datetime "return_on"
    t.datetime "rented_on"
    t.integer  "approver_id"
    t.integer  "fee",         :default => 0
    t.integer  "deposit",     :default => 0
    t.string   "note"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "gs3_roles", :id => false, :force => true do |t|
    t.integer "id",                 :default => 0,  :null => false
    t.string  "name", :limit => 64, :default => "", :null => false
  end

  create_table "gs3_roles_users", :id => false, :force => true do |t|
    t.integer "user_id", :default => 0, :null => false
    t.integer "role_id", :default => 0, :null => false
  end

  create_table "gs3_schema_migrations", :id => false, :force => true do |t|
    t.string "version", :null => false
  end

  add_index "gs3_schema_migrations", ["version"], :name => "gs3_unique_schema_migrations", :unique => true

  create_table "gs3_users", :id => false, :force => true do |t|
    t.integer "id",                           :default => 0,  :null => false
    t.string  "username", :limit => 60,       :default => "", :null => false
    t.string  "pass",     :limit => 32,       :default => "", :null => false
    t.string  "mail",     :limit => 64,       :default => ""
    t.text    "name",     :limit => 16777215
    t.string  "phone",    :limit => 15,       :default => "", :null => false
  end

  create_table "gs3_users_roles", :id => false, :force => true do |t|
    t.integer "user_id", :default => 0, :null => false
    t.integer "role_id", :default => 0, :null => false
  end

  create_table "gs_users", :id => false, :force => true do |t|
    t.integer "id",                                  :default => 0,  :null => false
    t.text    "first_name",    :limit => 2147483647
    t.text    "last_name",     :limit => 2147483647
    t.string  "email",         :limit => 64,         :default => ""
    t.string  "username",      :limit => 60,         :default => "", :null => false
    t.string  "password_hash", :limit => 32,         :default => "", :null => false
    t.integer "admin",                               :default => 0,  :null => false
  end

  create_table "history", :id => false, :force => true do |t|
    t.integer "uid",       :default => 0, :null => false
    t.integer "nid",       :default => 0, :null => false
    t.integer "timestamp", :default => 0, :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "gear_item_id"
    t.integer  "width"
    t.integer  "height"
    t.integer  "thumbnail_width"
    t.integer  "thumbnail_height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ledger_entries", :force => true do |t|
    t.decimal  "amount",       :precision => 10, :scale => 0
    t.integer  "payment_id"
    t.string   "payment_type"
    t.text     "note"
    t.integer  "approver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "rental_id"
    t.integer  "gear_item_id"
    t.decimal  "fee",                  :precision => 10, :scale => 0
    t.decimal  "deposit",              :precision => 10, :scale => 0
    t.datetime "returned_at"
    t.integer  "return_approver_id"
    t.datetime "deposit_processed_at"
    t.boolean  "deposit_withheld"
    t.integer  "deposit_approver_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailman_lists", :primary_key => "lid", :force => true do |t|
    t.string  "name",           :limit => 48,         :default => "", :null => false
    t.string  "command",        :limit => 72,         :default => "", :null => false
    t.string  "admin",          :limit => 48,         :default => ""
    t.string  "web",                                  :default => ""
    t.string  "webarch",                              :default => ""
    t.string  "lpass",          :limit => 20,         :default => ""
    t.integer "new_user_state", :limit => 1,          :default => 0
    t.text    "description",    :limit => 2147483647
  end

  create_table "mailman_users", :id => false, :force => true do |t|
    t.integer "lid",                   :default => 0,  :null => false
    t.integer "lstatus",               :default => 0,  :null => false
    t.string  "lmail",   :limit => 36, :default => "", :null => false
  end

  create_table "member_forms", :force => true do |t|
    t.integer  "ssid",                                             :null => false
    t.string   "email",              :limit => 72
    t.string   "notes",              :limit => 200
    t.integer  "entered_by",                                       :null => false
    t.integer  "entered_at",                                       :null => false
    t.integer  "batch"
    t.integer  "batch_pos"
    t.integer  "last_reminder",                     :default => 0
    t.integer  "num_reminders",                     :default => 0
    t.string   "membership_year",    :limit => 5
    t.integer  "user_id"
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "membership_type_id"
    t.string   "receipt",            :limit => 16
    t.integer  "membership_amount",                 :default => 0, :null => false
    t.integer  "membership_paid",                   :default => 0, :null => false
    t.integer  "indemnity",                         :default => 0, :null => false
    t.integer  "cards_issued",                      :default => 0, :null => false
    t.integer  "sra_stu_validated",                 :default => 0, :null => false
    t.integer  "anu_student"
    t.string   "home_phone",         :limit => 12
    t.string   "work_phone",         :limit => 12
    t.string   "mobile_phone",       :limit => 12
    t.string   "first_name",         :limit => 12
    t.string   "last_name",          :limit => 12
    t.string   "approver_name",      :limit => 32
  end

  create_table "membership_types", :force => true do |t|
    t.string   "name"
    t.decimal  "fee",        :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu", :primary_key => "mid", :force => true do |t|
    t.integer "pid",                      :default => 0,  :null => false
    t.string  "path",                     :default => "", :null => false
    t.string  "title",                    :default => "", :null => false
    t.string  "description",              :default => "", :null => false
    t.integer "weight",      :limit => 1, :default => 0,  :null => false
    t.integer "type",                     :default => 0,  :null => false
  end

  create_table "menu_per_role", :id => false, :force => true do |t|
    t.integer "mid", :default => 0, :null => false
    t.integer "rid", :default => 0, :null => false
  end

  create_table "modr8_log", :primary_key => "modid", :force => true do |t|
    t.integer "nid",                              :default => 0,  :null => false
    t.integer "uid",                              :default => 0,  :null => false
    t.integer "author_uid",                       :default => 0,  :null => false
    t.string  "action",     :limit => 16,         :default => "", :null => false
    t.string  "title",      :limit => 128,        :default => "", :null => false
    t.text    "message",    :limit => 2147483647,                 :null => false
    t.text    "teaser",     :limit => 2147483647,                 :null => false
    t.integer "timestamp",                        :default => 0,  :null => false
  end

  add_index "modr8_log", ["action"], :name => "action"
  add_index "modr8_log", ["nid", "modid"], :name => "nid_time"

  create_table "multiple_email", :primary_key => "eid", :force => true do |t|
    t.integer "uid",                                    :null => false
    t.string  "email",                                  :null => false
    t.integer "time_registered",                        :null => false
    t.boolean "confirmed",                              :null => false
    t.string  "confirm_code",                           :null => false
    t.integer "time_code_generated",                    :null => false
    t.boolean "attempts",            :default => false, :null => false
  end

  add_index "multiple_email", ["email"], :name => "email"
  add_index "multiple_email", ["uid"], :name => "uid"

  create_table "node", :id => false, :force => true do |t|
    t.integer "nid",                                     :null => false
    t.integer "vid",                     :default => 0,  :null => false
    t.string  "type",     :limit => 32,  :default => "", :null => false
    t.string  "title",    :limit => 128, :default => "", :null => false
    t.integer "uid",                     :default => 0,  :null => false
    t.integer "status",                  :default => 1,  :null => false
    t.integer "created",                 :default => 0,  :null => false
    t.integer "changed",                 :default => 0,  :null => false
    t.integer "comment",                 :default => 0,  :null => false
    t.integer "promote",                 :default => 0,  :null => false
    t.integer "moderate",                :default => 0,  :null => false
    t.integer "sticky",                  :default => 0,  :null => false
  end

  add_index "node", ["changed"], :name => "node_changed"
  add_index "node", ["created"], :name => "node_created"
  add_index "node", ["moderate"], :name => "node_moderate"
  add_index "node", ["nid"], :name => "nid"
  add_index "node", ["promote", "status"], :name => "node_promote_status"
  add_index "node", ["status", "type", "nid"], :name => "node_status_type"
  add_index "node", ["status"], :name => "status"
  add_index "node", ["title", "type"], :name => "node_title_type", :length => {"title"=>nil, "type"=>4}
  add_index "node", ["type"], :name => "node_type", :length => {"type"=>4}
  add_index "node", ["uid"], :name => "uid"
  add_index "node", ["vid"], :name => "vid", :unique => true

  create_table "node_access", :id => false, :force => true do |t|
    t.integer "nid",                       :default => 0,  :null => false
    t.integer "gid",                       :default => 0,  :null => false
    t.string  "realm",                     :default => "", :null => false
    t.integer "grant_view",   :limit => 1, :default => 0,  :null => false
    t.integer "grant_update", :limit => 1, :default => 0,  :null => false
    t.integer "grant_delete", :limit => 1, :default => 0,  :null => false
  end

  create_table "node_comment_statistics", :primary_key => "nid", :force => true do |t|
    t.integer "last_comment_timestamp",               :default => 0, :null => false
    t.string  "last_comment_name",      :limit => 60
    t.integer "last_comment_uid",                     :default => 0, :null => false
    t.integer "comment_count",                        :default => 0, :null => false
  end

  add_index "node_comment_statistics", ["last_comment_timestamp"], :name => "node_comment_timestamp"

  create_table "node_counter", :primary_key => "nid", :force => true do |t|
    t.integer "totalcount", :limit => 8, :default => 0, :null => false
    t.integer "daycount",   :limit => 3, :default => 0, :null => false
    t.integer "timestamp",               :default => 0, :null => false
  end

  add_index "node_counter", ["daycount"], :name => "daycount"
  add_index "node_counter", ["timestamp"], :name => "timestamp"
  add_index "node_counter", ["totalcount"], :name => "totalcount"

  create_table "node_field", :primary_key => "field_name", :force => true do |t|
    t.string  "type",            :limit => 127,      :default => "", :null => false
    t.text    "global_settings", :limit => 16777215,                 :null => false
    t.integer "required",                            :default => 0,  :null => false
    t.integer "multiple",                            :default => 0,  :null => false
    t.integer "db_storage",                          :default => 0,  :null => false
  end

  create_table "node_field_instance", :id => false, :force => true do |t|
    t.string  "field_name",       :limit => 32,       :default => "", :null => false
    t.string  "type_name",        :limit => 32,       :default => "", :null => false
    t.integer "weight",                               :default => 0,  :null => false
    t.string  "label",                                :default => "", :null => false
    t.string  "widget_type",      :limit => 32,       :default => "", :null => false
    t.text    "widget_settings",  :limit => 16777215,                 :null => false
    t.text    "display_settings", :limit => 16777215,                 :null => false
    t.text    "description",      :limit => 16777215,                 :null => false
  end

  create_table "node_group", :id => false, :force => true do |t|
    t.string  "type_name",  :limit => 32,       :default => "", :null => false
    t.string  "group_name", :limit => 32,       :default => "", :null => false
    t.string  "label",                          :default => "", :null => false
    t.text    "settings",   :limit => 16777215,                 :null => false
    t.integer "weight",     :limit => 1,                        :null => false
  end

  create_table "node_group_fields", :id => false, :force => true do |t|
    t.string "type_name",  :limit => 32, :default => "", :null => false
    t.string "group_name", :limit => 32, :default => "", :null => false
    t.string "field_name", :limit => 32, :default => "", :null => false
  end

  create_table "node_revisions", :primary_key => "vid", :force => true do |t|
    t.integer "nid",                                             :null => false
    t.integer "uid",                             :default => 0,  :null => false
    t.string  "title",     :limit => 128,        :default => "", :null => false
    t.text    "body",      :limit => 2147483647,                 :null => false
    t.text    "teaser",    :limit => 2147483647,                 :null => false
    t.text    "log",       :limit => 2147483647,                 :null => false
    t.integer "timestamp",                       :default => 0,  :null => false
    t.integer "format",                          :default => 0,  :null => false
  end

  add_index "node_revisions", ["nid"], :name => "nid"
  add_index "node_revisions", ["uid"], :name => "uid"

  create_table "node_type", :primary_key => "type", :force => true do |t|
    t.string  "name",                               :default => "", :null => false
    t.string  "module",                                             :null => false
    t.text    "description",    :limit => 16777215,                 :null => false
    t.text    "help",           :limit => 16777215,                 :null => false
    t.integer "has_title",      :limit => 1,                        :null => false
    t.string  "title_label",                        :default => "", :null => false
    t.integer "has_body",       :limit => 1,                        :null => false
    t.string  "body_label",                         :default => "", :null => false
    t.integer "min_word_count", :limit => 2,                        :null => false
    t.integer "custom",         :limit => 1,        :default => 0,  :null => false
    t.integer "modified",       :limit => 1,        :default => 0,  :null => false
    t.integer "locked",         :limit => 1,        :default => 0,  :null => false
    t.string  "orig_type",                          :default => "", :null => false
  end

  create_table "nodeaccess", :id => false, :force => true do |t|
    t.integer "nid",          :default => 0,     :null => false
    t.integer "gid",          :default => 0,     :null => false
    t.string  "realm",        :default => "",    :null => false
    t.boolean "grant_view",   :default => false, :null => false
    t.boolean "grant_update", :default => false, :null => false
    t.boolean "grant_delete", :default => false, :null => false
  end

  create_table "overdue_items_emails", :force => true do |t|
    t.text     "body"
    t.string   "to"
    t.integer  "user_id"
    t.integer  "approver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panels_display", :primary_key => "did", :force => true do |t|
    t.string "name"
    t.string "layout",          :limit => 32
    t.text   "layout_settings", :limit => 2147483647
    t.text   "panel_settings",  :limit => 2147483647
    t.text   "cache"
  end

  add_index "panels_display", ["name"], :name => "name", :unique => true

  create_table "panels_object_cache", :id => false, :force => true do |t|
    t.string  "sid",       :limit => 64
    t.integer "did"
    t.string  "obj"
    t.text    "data"
    t.integer "timestamp"
  end

  add_index "panels_object_cache", ["sid", "obj", "did"], :name => "panels_object_cache_idx"
  add_index "panels_object_cache", ["sid", "obj", "did"], :name => "sid"
  add_index "panels_object_cache", ["timestamp"], :name => "timestamp"

  create_table "panels_page", :primary_key => "pid", :force => true do |t|
    t.string  "name"
    t.integer "did"
    t.string  "title",                        :limit => 128
    t.string  "access",                       :limit => 128
    t.string  "path",                         :limit => 128
    t.string  "css_id",                       :limit => 128
    t.text    "css",                          :limit => 2147483647
    t.text    "arguments",                    :limit => 2147483647
    t.text    "displays",                     :limit => 2147483647
    t.text    "contexts",                     :limit => 2147483647
    t.text    "relationships",                :limit => 2147483647
    t.integer "no_blocks",                                          :default => 0
    t.integer "menu",                                               :default => 0
    t.integer "menu_tab"
    t.integer "menu_tab_weight"
    t.string  "menu_title"
    t.integer "menu_tab_default"
    t.string  "menu_tab_default_parent_type", :limit => 10
    t.string  "menu_parent_title"
    t.integer "menu_parent_tab_weight"
  end

  add_index "panels_page", ["name"], :name => "name", :unique => true
  add_index "panels_page", ["name"], :name => "name_2"
  add_index "panels_page", ["path"], :name => "path"

  create_table "panels_pane", :id => false, :force => true do |t|
    t.integer "pid",                                 :default => 0, :null => false
    t.integer "did",                                 :default => 0, :null => false
    t.string  "panel",         :limit => 32
    t.string  "type",          :limit => 32
    t.string  "subtype",       :limit => 64
    t.string  "access",        :limit => 128
    t.text    "configuration", :limit => 2147483647
    t.text    "cache",         :limit => 2147483647
    t.integer "position"
  end

  add_index "panels_pane", ["did"], :name => "did"

  create_table "panels_views", :primary_key => "pvid", :force => true do |t|
    t.string  "view"
    t.string  "name"
    t.string  "description"
    t.string  "title"
    t.string  "category"
    t.integer "category_weight"
    t.string  "view_type"
    t.integer "use_pager"
    t.integer "pager_id"
    t.integer "nodes_per_page"
    t.integer "offset"
    t.integer "link_to_view"
    t.integer "more_link"
    t.integer "feed_icons"
    t.integer "url_override"
    t.string  "url"
    t.integer "url_from_panel"
    t.text    "contexts"
    t.integer "allow_type"
    t.integer "allow_nodes_per_page"
    t.integer "allow_offset"
    t.integer "allow_use_pager"
    t.integer "allow_link_to_view"
    t.integer "allow_more_link"
    t.integer "allow_feed_icons"
    t.integer "allow_url_override"
    t.integer "allow_url_from_panel"
  end

  add_index "panels_views", ["name"], :name => "name", :unique => true

  create_table "permission", :id => false, :force => true do |t|
    t.integer "rid",                        :default => 0, :null => false
    t.text    "perm", :limit => 2147483647
    t.integer "tid",                        :default => 0, :null => false
  end

  add_index "permission", ["rid"], :name => "rid"

  create_table "rentals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "approver_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role", :primary_key => "rid", :force => true do |t|
    t.string "name", :limit => 64, :default => "", :null => false
  end

  add_index "role", ["name"], :name => "name", :unique => true

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "sequences", :primary_key => "name", :force => true do |t|
    t.integer "id", :default => 0, :null => false
  end

  create_table "sessions", :primary_key => "sid", :force => true do |t|
    t.integer "uid",                                             :null => false
    t.string  "hostname",  :limit => 128,        :default => "", :null => false
    t.integer "timestamp",                       :default => 0,  :null => false
    t.integer "cache",                           :default => 0,  :null => false
    t.text    "session",   :limit => 2147483647
  end

  add_index "sessions", ["timestamp"], :name => "timestamp"
  add_index "sessions", ["uid"], :name => "uid"

  create_table "signup", :primary_key => "nid", :force => true do |t|
    t.string  "forwarding_email",      :limit => 64,         :default => "", :null => false
    t.integer "send_confirmation",                           :default => 0,  :null => false
    t.text    "confirmation_email",    :limit => 2147483647,                 :null => false
    t.integer "send_reminder",                               :default => 0,  :null => false
    t.integer "reminder_days_before",                        :default => 0,  :null => false
    t.text    "reminder_email",        :limit => 2147483647,                 :null => false
    t.integer "close_in_advance_time",                       :default => 0,  :null => false
    t.integer "close_signup_limit",                          :default => 0,  :null => false
    t.integer "status",                                      :default => 1,  :null => false
    t.integer "allow_self_remove"
  end

  create_table "signup_bios", :primary_key => "nid", :force => true do |t|
    t.string  "forwarding_email",        :limit => 64,         :default => "", :null => false
    t.integer "send_confirmation",                             :default => 0,  :null => false
    t.text    "confirmation_email",      :limit => 2147483647,                 :null => false
    t.integer "send_reminder",                                 :default => 0,  :null => false
    t.integer "reminder_days_before",                          :default => 0,  :null => false
    t.text    "reminder_email",          :limit => 2147483647,                 :null => false
    t.integer "close_in_advance_time",                         :default => 0,  :null => false
    t.integer "close_signup_bios_limit",                       :default => 0,  :null => false
    t.integer "status",                                        :default => 1,  :null => false
  end

  create_table "signup_bios_log", :id => false, :force => true do |t|
    t.integer "uid",                                    :default => 0,  :null => false
    t.integer "nid",                                    :default => 0,  :null => false
    t.string  "anon_mail",                              :default => "", :null => false
    t.integer "signup_bios_time",                       :default => 0,  :null => false
    t.text    "form_data",        :limit => 2147483647,                 :null => false
  end

  add_index "signup_bios_log", ["nid"], :name => "nid"
  add_index "signup_bios_log", ["uid"], :name => "uid"

  create_table "signup_log", :id => false, :force => true do |t|
    t.integer "uid",                                            :default => 0,  :null => false
    t.integer "nid",                                            :default => 0,  :null => false
    t.string  "anon_mail",                                      :default => "", :null => false
    t.integer "signup_time",                                    :default => 0,  :null => false
    t.text    "form_data",                :limit => 2147483647,                 :null => false
    t.string  "f_medical",                :limit => 1
    t.text    "f_vehicle_make_model",     :limit => 2147483647
    t.string  "f_vehicle_registration",   :limit => 15
    t.integer "f_vehicle_num_seats"
    t.integer "f_vehicle_all_parks_pass"
    t.text    "f_vehicle_comment",        :limit => 2147483647
    t.text    "f_additional_info",        :limit => 2147483647
  end

  add_index "signup_log", ["nid"], :name => "nid"
  add_index "signup_log", ["uid"], :name => "uid"

  create_table "sra_members", :id => false, :force => true do |t|
    t.integer "sra_number",                     :null => false
    t.string  "surname",         :limit => 100
    t.string  "given_names",     :limit => 100
    t.string  "mem_description", :limit => 50
    t.string  "status",          :limit => 20
  end

  create_table "system", :primary_key => "filename", :force => true do |t|
    t.string  "name",                        :default => "", :null => false
    t.string  "type",                        :default => "", :null => false
    t.string  "description",                 :default => "", :null => false
    t.integer "status",                      :default => 0,  :null => false
    t.integer "throttle",       :limit => 1, :default => 0,  :null => false
    t.integer "bootstrap",                   :default => 0,  :null => false
    t.integer "schema_version", :limit => 2, :default => -1, :null => false
    t.integer "weight",                      :default => 0,  :null => false
  end

  add_index "system", ["weight"], :name => "weight"

  create_table "term_data", :primary_key => "tid", :force => true do |t|
    t.integer "vid",                               :default => 0,  :null => false
    t.string  "name",                              :default => "", :null => false
    t.text    "description", :limit => 2147483647
    t.integer "weight",      :limit => 1,          :default => 0,  :null => false
  end

  add_index "term_data", ["vid"], :name => "vid"

  create_table "term_hierarchy", :id => false, :force => true do |t|
    t.integer "tid",    :default => 0, :null => false
    t.integer "parent", :default => 0, :null => false
  end

  add_index "term_hierarchy", ["parent"], :name => "parent"
  add_index "term_hierarchy", ["tid"], :name => "tid"

  create_table "term_node", :id => false, :force => true do |t|
    t.integer "nid", :default => 0, :null => false
    t.integer "tid", :default => 0, :null => false
  end

  add_index "term_node", ["nid"], :name => "nid"
  add_index "term_node", ["tid"], :name => "tid"

  create_table "term_relation", :id => false, :force => true do |t|
    t.integer "tid1", :default => 0, :null => false
    t.integer "tid2", :default => 0, :null => false
  end

  add_index "term_relation", ["tid1"], :name => "tid1"
  add_index "term_relation", ["tid2"], :name => "tid2"

  create_table "term_synonym", :id => false, :force => true do |t|
    t.integer "tid",  :default => 0,  :null => false
    t.string  "name", :default => "", :null => false
  end

  add_index "term_synonym", ["name"], :name => "name", :length => {"name"=>3}
  add_index "term_synonym", ["tid"], :name => "tid"

  create_table "url_alias", :primary_key => "pid", :force => true do |t|
    t.string "src", :limit => 128, :default => "", :null => false
    t.string "dst", :limit => 128, :default => "", :null => false
  end

  add_index "url_alias", ["dst"], :name => "dst", :unique => true
  add_index "url_alias", ["src"], :name => "src"

  create_table "user_data", :id => false, :force => true do |t|
    t.integer "uid",                                          :default => 0,  :null => false
    t.string  "mail",                   :limit => 64,         :default => ""
    t.string  "name",                   :limit => 60,         :default => "", :null => false
    t.integer "vid",                                          :default => 0,  :null => false
    t.integer "nid",                                          :default => 0,  :null => false
    t.text    "field_first_name_value", :limit => 2147483647
    t.text    "field_last_name_value",  :limit => 2147483647
  end

  create_table "user_profile", :id => false, :force => true do |t|
    t.integer "uid",                                                        :default => 0,  :null => false
    t.string  "name",                                 :limit => 60,         :default => "", :null => false
    t.string  "pass",                                 :limit => 32,         :default => "", :null => false
    t.string  "mail",                                 :limit => 64,         :default => ""
    t.integer "mode",                                 :limit => 1,          :default => 0,  :null => false
    t.integer "sort",                                 :limit => 1,          :default => 0
    t.integer "threshold",                            :limit => 1,          :default => 0
    t.string  "theme",                                                      :default => "", :null => false
    t.string  "signature",                                                  :default => "", :null => false
    t.integer "created",                                                    :default => 0,  :null => false
    t.integer "access",                                                     :default => 0,  :null => false
    t.integer "login",                                                      :default => 0,  :null => false
    t.integer "status",                               :limit => 1,          :default => 0,  :null => false
    t.string  "timezone",                             :limit => 8
    t.string  "language",                             :limit => 12,         :default => "", :null => false
    t.string  "picture",                                                    :default => "", :null => false
    t.string  "init",                                 :limit => 64,         :default => ""
    t.text    "data",                                 :limit => 2147483647
    t.integer "vid",                                                        :default => 0,  :null => false
    t.integer "nid",                                                        :default => 0,  :null => false
    t.text    "field_first_name_value",               :limit => 2147483647
    t.text    "field_last_name_value",                :limit => 2147483647
    t.text    "field_first_aid_qualifications_value", :limit => 2147483647
    t.integer "field_medical_conditions_value"
    t.text    "field_nok_full_name_value",            :limit => 2147483647
    t.string  "field_nok_phone_value",                :limit => 20,         :default => "", :null => false
    t.text    "field_nok_address_value",              :limit => 2147483647
    t.string  "field_gender_value",                   :limit => 1,          :default => "", :null => false
    t.text    "field_address_value",                  :limit => 2147483647
    t.integer "field_anu_student_value"
    t.string  "field_mobile_phone_value",             :limit => 15,         :default => "", :null => false
    t.string  "field_home_phone_value",               :limit => 15,         :default => "", :null => false
    t.string  "field_work_phone_value",               :limit => 15,         :default => "", :null => false
    t.text    "field_vehicle_make_model_value",       :limit => 2147483647
    t.integer "field_vehicle_all_parks_pass_value"
    t.string  "field_vehicle_registration_value",     :limit => 15,         :default => "", :null => false
    t.text    "field_vehicle_num_seats_value",        :limit => 2147483647
    t.integer "field_stu_sra_number_value"
    t.integer "is_member",                                                  :default => 0,  :null => false
    t.integer "is_committee",                                               :default => 0,  :null => false
    t.integer "has_member_form"
  end

  create_table "users", :primary_key => "uid", :force => true do |t|
    t.string  "name",      :limit => 60,         :default => "", :null => false
    t.string  "pass",      :limit => 32,         :default => "", :null => false
    t.string  "mail",      :limit => 64,         :default => ""
    t.integer "mode",      :limit => 1,          :default => 0,  :null => false
    t.integer "sort",      :limit => 1,          :default => 0
    t.integer "threshold", :limit => 1,          :default => 0
    t.string  "theme",                           :default => "", :null => false
    t.string  "signature",                       :default => "", :null => false
    t.integer "created",                         :default => 0,  :null => false
    t.integer "access",                          :default => 0,  :null => false
    t.integer "login",                           :default => 0,  :null => false
    t.integer "status",    :limit => 1,          :default => 0,  :null => false
    t.string  "timezone",  :limit => 8
    t.string  "language",  :limit => 12,         :default => "", :null => false
    t.string  "picture",                         :default => "", :null => false
    t.string  "init",      :limit => 64,         :default => ""
    t.text    "data",      :limit => 2147483647
  end

  add_index "users", ["access"], :name => "access"
  add_index "users", ["created"], :name => "created"
  add_index "users", ["name"], :name => "name", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "uid", :default => 0, :null => false
    t.integer "rid", :default => 0, :null => false
  end

  create_table "variable", :primary_key => "name", :force => true do |t|
    t.text "value", :limit => 2147483647, :null => false
  end

  create_table "view_argument", :id => false, :force => true do |t|
    t.integer "vid",                                 :default => 0, :null => false
    t.string  "type"
    t.string  "argdefault"
    t.string  "title"
    t.string  "options"
    t.integer "position"
    t.string  "wildcard",              :limit => 32
    t.string  "wildcard_substitution", :limit => 32
  end

  add_index "view_argument", ["vid"], :name => "vid"

  create_table "view_exposed_filter", :id => false, :force => true do |t|
    t.integer "vid",        :default => 0, :null => false
    t.string  "field"
    t.string  "label"
    t.integer "optional"
    t.integer "is_default"
    t.integer "operator"
    t.integer "single"
    t.integer "position"
  end

  add_index "view_exposed_filter", ["vid"], :name => "vid"

  create_table "view_filter", :id => false, :force => true do |t|
    t.integer "vid",                             :default => 0, :null => false
    t.string  "tablename"
    t.string  "field"
    t.text    "value",     :limit => 2147483647
    t.string  "operator",  :limit => 20
    t.string  "options"
    t.integer "position"
  end

  add_index "view_filter", ["vid"], :name => "vid"

  create_table "view_sort", :id => false, :force => true do |t|
    t.integer "vid",                    :default => 0, :null => false
    t.integer "position"
    t.string  "field"
    t.string  "sortorder", :limit => 5
    t.string  "options"
    t.string  "tablename"
  end

  add_index "view_sort", ["vid"], :name => "vid"

  create_table "view_tablefield", :id => false, :force => true do |t|
    t.integer "vid",                      :default => 0, :null => false
    t.string  "tablename"
    t.string  "field"
    t.string  "label"
    t.string  "handler"
    t.integer "sortable"
    t.string  "defaultsort", :limit => 5
    t.string  "options"
    t.integer "position"
  end

  add_index "view_tablefield", ["vid"], :name => "vid"

  create_table "view_view", :primary_key => "vid", :force => true do |t|
    t.string  "name",                         :limit => 32,         :null => false
    t.string  "description"
    t.string  "access"
    t.integer "page"
    t.string  "page_title"
    t.text    "page_header",                  :limit => 2147483647
    t.integer "page_header_format",                                 :null => false
    t.text    "page_empty",                   :limit => 2147483647
    t.integer "page_empty_format",                                  :null => false
    t.text    "page_footer",                  :limit => 2147483647
    t.integer "page_footer_format",                                 :null => false
    t.string  "page_type",                    :limit => 20
    t.integer "use_pager"
    t.integer "nodes_per_page"
    t.string  "url"
    t.integer "menu"
    t.integer "menu_tab"
    t.integer "menu_tab_weight"
    t.string  "menu_title"
    t.integer "menu_tab_default"
    t.string  "menu_tab_default_parent_type", :limit => 10
    t.string  "menu_parent_title"
    t.integer "menu_parent_tab_weight"
    t.integer "block"
    t.string  "block_title"
    t.integer "block_use_page_header"
    t.text    "block_header",                 :limit => 2147483647
    t.integer "block_header_format",                                :null => false
    t.integer "block_use_page_footer"
    t.text    "block_footer",                 :limit => 2147483647
    t.integer "block_footer_format",                                :null => false
    t.integer "block_use_page_empty"
    t.text    "block_empty",                  :limit => 2147483647
    t.integer "block_empty_format",                                 :null => false
    t.string  "block_type",                   :limit => 20
    t.integer "nodes_per_block"
    t.integer "block_more"
    t.integer "breadcrumb_no_home"
    t.integer "changed"
    t.text    "view_args_php",                :limit => 2147483647
    t.integer "is_cacheable"
  end

  add_index "view_view", ["name"], :name => "name", :unique => true
  add_index "view_view", ["name"], :name => "name_2"

  create_table "vocabulary", :primary_key => "vid", :force => true do |t|
    t.string  "name",                              :default => "", :null => false
    t.text    "description", :limit => 2147483647
    t.string  "help",                              :default => "", :null => false
    t.integer "relations",   :limit => 1,          :default => 0,  :null => false
    t.integer "hierarchy",   :limit => 1,          :default => 0,  :null => false
    t.integer "multiple",    :limit => 1,          :default => 0,  :null => false
    t.integer "required",    :limit => 1,          :default => 0,  :null => false
    t.integer "tags",        :limit => 1,          :default => 0,  :null => false
    t.string  "module",                            :default => "", :null => false
    t.integer "weight",      :limit => 1,          :default => 0,  :null => false
  end

  create_table "vocabulary_node_types", :id => false, :force => true do |t|
    t.integer "vid",                :default => 0,  :null => false
    t.string  "type", :limit => 32, :default => "", :null => false
  end

  create_table "watchdog", :primary_key => "wid", :force => true do |t|
    t.integer "uid",                             :default => 0,  :null => false
    t.string  "type",      :limit => 16,         :default => "", :null => false
    t.text    "message",   :limit => 2147483647,                 :null => false
    t.integer "severity",  :limit => 1,          :default => 0,  :null => false
    t.string  "link",                            :default => "", :null => false
    t.text    "location",                                        :null => false
    t.string  "referer",   :limit => 128,        :default => "", :null => false
    t.string  "hostname",  :limit => 128,        :default => "", :null => false
    t.integer "timestamp",                       :default => 0,  :null => false
  end

  add_index "watchdog", ["type"], :name => "type"

end
