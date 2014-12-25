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

ActiveRecord::Schema.define(version: 20141225123124) do

  create_table "sape_configs", force: true do |t|
    t.string "site_host"
    t.string "name"
    t.text   "value",     limit: 500
  end

  create_table "sape_links", force: true do |t|
    t.string "site_host"
    t.string "page"
    t.string "anchor"
    t.string "url"
    t.string "host"
    t.text   "raw_link",  limit: 500
    t.string "link_type"
  end

  add_index "sape_links", ["link_type", "page", "site_host"], name: "index_sape_links_on_link_type_and_page_and_site_host"

end
