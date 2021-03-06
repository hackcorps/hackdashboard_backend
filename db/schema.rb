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

ActiveRecord::Schema.define(version: 20151123120705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "milestones", force: :cascade do |t|
    t.string   "name"
    t.decimal  "percent_complete", precision: 5, scale: 2
    t.datetime "data_started"
    t.integer  "cost"
    t.integer  "organization_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.date     "due_date"
  end

  add_index "milestones", ["organization_id"], name: "index_milestones_on_organization_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stand_up_summaries", force: :cascade do |t|
    t.datetime "noted_date"
    t.string   "text"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "stand_up_summaries", ["organization_id"], name: "index_stand_up_summaries_on_organization_id", using: :btree

  create_table "stand_ups", force: :cascade do |t|
    t.string   "update_text"
    t.date     "noted_at"
    t.integer  "user_id"
    t.integer  "milestone_id"
    t.integer  "stand_up_summary_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "stand_ups", ["milestone_id"], name: "index_stand_ups_on_milestone_id", using: :btree
  add_index "stand_ups", ["stand_up_summary_id"], name: "index_stand_ups_on_stand_up_summary_id", using: :btree
  add_index "stand_ups", ["user_id"], name: "index_stand_ups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "cost_per_month",         default: 0,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.string   "invite_token"
    t.string   "full_name"
    t.datetime "invite_token_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_organizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users_organizations", ["organization_id"], name: "index_users_organizations_on_organization_id", using: :btree
  add_index "users_organizations", ["user_id"], name: "index_users_organizations_on_user_id", using: :btree

  add_foreign_key "milestones", "organizations"
  add_foreign_key "stand_up_summaries", "organizations"
  add_foreign_key "stand_ups", "milestones"
  add_foreign_key "stand_ups", "stand_up_summaries"
  add_foreign_key "stand_ups", "users"
end
