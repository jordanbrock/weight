ActiveRecord::Schema.define do
  create_table "weight_records", force: true do |t|
    t.decimal "ordered", precision: 8, scale: 3, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
