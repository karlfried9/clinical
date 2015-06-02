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

ActiveRecord::Schema.define(version: 20150514012446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "activities", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.integer  "type_id"
    t.boolean  "billable"
    t.decimal  "amount"
    t.string   "code_type"
    t.string   "code"
    t.string   "currency_code"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "activity_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arms", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "clinical_trial_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "clinical_trial_activities", force: :cascade do |t|
    t.integer  "clinical_trial_visit_id"
    t.integer  "activity_id"
    t.boolean  "performed"
    t.boolean  "billable"
    t.integer  "amount"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "clinical_trial_attachments", force: :cascade do |t|
    t.integer  "clinical_trial_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
  end

  create_table "clinical_trial_maskings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_trial_organs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_trial_phases", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_trial_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_trial_visit_formats", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_trial_visit_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_trial_visits", force: :cascade do |t|
    t.integer  "clinical_trial_id"
    t.string   "name"
    t.string   "description"
    t.integer  "type_id"
    t.integer  "format_id"
    t.integer  "offset_days"
    t.integer  "after_visit_id"
    t.integer  "tolerance_number_of_days"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "clinical_trials", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "trial_sponsor_id"
    t.string   "protocol_id"
    t.string   "study_title"
    t.string   "phase_id"
    t.string   "status_id"
    t.string   "drug_name"
    t.string   "organ_id"
    t.integer  "disease_stage_id"
    t.string   "study_acronym"
    t.string   "official_study_title"
    t.string   "secondary_ids"
    t.date     "enrollment_begin_date"
    t.date     "enrollment_end_date"
    t.date     "primary_completion_date"
    t.date     "study_completion_date"
    t.integer  "masking_id"
    t.integer  "overall_study_status_id"
    t.integer  "recruitment_status_at_facility_id"
    t.string   "principal_investigator"
    t.string   "clinical_assistant"
    t.string   "other_information"
    t.date     "start_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "billing_to"
    t.string   "bill_to_email"
    t.integer  "expected_trial_enrollment_count"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "disease_stages", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.text     "description"
    t.string   "status"
    t.date     "created_date"
    t.text     "mailing_address"
    t.text     "notes"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "clinical_trial_id"
    t.date     "fromdate"
    t.date     "todate"
    t.string   "dateoption"
    t.integer  "organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "billing_from"
  end

  create_table "patient_activities", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "patient_visit_id"
    t.integer  "activity_id"
    t.date     "activity_date"
    t.boolean  "performed"
    t.boolean  "billable"
    t.integer  "amount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "patient_activity_invoices", force: :cascade do |t|
    t.integer  "patient_activity_id"
    t.integer  "invoice_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "patient_assigned_visits", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "clinical_trial_visit_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "patient_visit_schedules", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "clinical_trial_visit_id"
    t.date     "schedule_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "patient_visits", force: :cascade do |t|
    t.integer  "clinical_trial_visit_id"
    t.integer  "patient_id"
    t.string   "description"
    t.date     "recorded_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "clinical_trial_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string   "salutation"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "patient_id"
    t.date     "date_of_birth"
    t.text     "notes"
    t.integer  "clinical_trial_id"
    t.integer  "arm_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "organization_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "invoice_id"
    t.decimal  "amount"
    t.string   "currency_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "study_statuses", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trial_sponsors", force: :cascade do |t|
    t.string   "name"
    t.text     "contact_info"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role_id"
    t.integer  "organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
