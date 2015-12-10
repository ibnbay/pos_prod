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

ActiveRecord::Schema.define(version: 20151020194805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "barangs", force: :cascade do |t|
    t.string   "nama"
    t.integer  "stock"
    t.decimal  "satuan"
    t.boolean  "status"
    t.integer  "kategori_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "barangs", ["kategori_id"], name: "index_barangs_on_kategori_id", using: :btree

  create_table "detail_penjualans", force: :cascade do |t|
    t.integer  "jumlah"
    t.decimal  "amount"
    t.integer  "penjualan_id"
    t.integer  "barang_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "detail_penjualans", ["barang_id"], name: "index_detail_penjualans_on_barang_id", using: :btree
  add_index "detail_penjualans", ["penjualan_id"], name: "index_detail_penjualans_on_penjualan_id", using: :btree

  create_table "h_barangs", force: :cascade do |t|
    t.decimal  "satuan"
    t.integer  "barang_id"
    t.integer  "r_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "h_barangs", ["barang_id"], name: "index_h_barangs_on_barang_id", using: :btree
  add_index "h_barangs", ["r_class_id"], name: "index_h_barangs_on_r_class_id", using: :btree

  create_table "kategoris", force: :cascade do |t|
    t.string   "nama"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "penjualans", force: :cascade do |t|
    t.date     "tanggal"
    t.decimal  "total"
    t.integer  "status"
    t.integer  "reseller_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "penjualans", ["reseller_id"], name: "index_penjualans_on_reseller_id", using: :btree

  create_table "r_classes", force: :cascade do |t|
    t.string   "nama"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resellers", force: :cascade do |t|
    t.string   "nama"
    t.text     "alamat"
    t.string   "tlp"
    t.boolean  "status"
    t.integer  "user_id"
    t.integer  "r_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  add_index "resellers", ["r_class_id"], name: "index_resellers_on_r_class_id", using: :btree

  add_foreign_key "barangs", "kategoris"
  add_foreign_key "detail_penjualans", "barangs"
  add_foreign_key "detail_penjualans", "penjualans"
  add_foreign_key "h_barangs", "barangs"
  add_foreign_key "h_barangs", "r_classes"
  add_foreign_key "penjualans", "resellers"
  add_foreign_key "resellers", "r_classes"
end
