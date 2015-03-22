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

ActiveRecord::Schema.define(version: 20150315203921) do

  create_table "clusters", force: :cascade do |t|
    t.integer "group",           limit: 4
    t.integer "stress_response", limit: 4
    t.integer "time_response",   limit: 4
    t.float   "silhouette",      limit: 24
    t.float   "dbi",             limit: 24
    t.float   "dunn",            limit: 24
  end

  create_table "expressiondifferences", force: :cascade do |t|
    t.string  "gene",       limit: 10
    t.integer "time1",      limit: 4
    t.string  "condition1", limit: 10
    t.integer "time2",      limit: 4
    t.string  "condition2", limit: 10
    t.float   "foldchange", limit: 24
    t.float   "pval",       limit: 24
  end

  add_index "expressiondifferences", ["gene", "time1", "time2", "condition1", "condition2"], name: "diff_exp", unique: true, using: :btree

  create_table "expressions", force: :cascade do |t|
    t.string  "gene",       limit: 10
    t.integer "time",       limit: 4
    t.string  "condition",  limit: 10
    t.integer "replicate",  limit: 4
    t.float   "expression", limit: 24
  end

  add_index "expressions", ["gene", "time", "condition"], name: "index_expressions_on_gene_and_time_and_condition", using: :btree

  create_table "genes", force: :cascade do |t|
    t.string  "gene",  limit: 10
    t.integer "group", limit: 4
    t.string  "url",   limit: 255
  end

end
