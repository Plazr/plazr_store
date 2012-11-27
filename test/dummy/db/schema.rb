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

ActiveRecord::Schema.define(:version => 20121114224643) do

  create_table "plazr_store_addresses", :force => true do |t|
    t.string   "first_name",        :null => false
    t.string   "last_name",         :null => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "alternative_phone"
    t.string   "company"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "plazr_store_addresses", ["first_name"], :name => "index_plazr_store_addresses_on_first_name"
  add_index "plazr_store_addresses", ["last_name"], :name => "index_plazr_store_addresses_on_last_name"

  create_table "plazr_store_brands", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plazr_store_cart_variants", :force => true do |t|
    t.integer  "amount",     :default => 1, :null => false
    t.integer  "cart_id",                   :null => false
    t.integer  "variant_id",                :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "plazr_store_cart_variants", ["cart_id", "variant_id"], :name => "index_plazr_store_cart_variants_on_cart_id_and_variant_id", :unique => true

  create_table "plazr_store_carts", :force => true do |t|
    t.integer  "item_amount",                               :default => 0, :null => false
    t.decimal  "total_price", :precision => 8, :scale => 2,                :null => false
    t.integer  "user_id",                                                  :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  add_index "plazr_store_carts", ["user_id"], :name => "index_plazr_store_carts_on_user_id"

  create_table "plazr_store_category_conditions", :force => true do |t|
    t.text     "description", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plazr_store_conditions", :force => true do |t|
    t.string   "condition",             :null => false
    t.integer  "category_condition_id", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "plazr_store_conditions", ["category_condition_id"], :name => "index_plazr_store_conditions_on_category_condition_id"

  create_table "plazr_store_coupons", :force => true do |t|
    t.string   "code",                            :null => false
    t.text     "description"
    t.string   "value",                           :null => false
    t.integer  "minimum_cart"
    t.datetime "starts_at",                       :null => false
    t.datetime "expires_at"
    t.integer  "uses_allowed",     :default => 1
    t.integer  "times_used",       :default => 0
    t.integer  "discount_type_id",                :null => false
    t.integer  "user_id",                         :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "plazr_store_coupons", ["code"], :name => "index_plazr_store_coupons_on_code"
  add_index "plazr_store_coupons", ["discount_type_id"], :name => "index_plazr_store_coupons_on_discount_type_id"
  add_index "plazr_store_coupons", ["user_id"], :name => "index_plazr_store_coupons_on_user_id"

  create_table "plazr_store_discount_types", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plazr_store_feedback_products", :force => true do |t|
    t.text     "comment"
    t.integer  "rating",     :null => false
    t.integer  "user_id",    :null => false
    t.integer  "product_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plazr_store_feedback_products", ["product_id"], :name => "index_plazr_store_feedback_products_on_product_id"
  add_index "plazr_store_feedback_products", ["user_id"], :name => "index_plazr_store_feedback_products_on_user_id"

  create_table "plazr_store_feedback_stores", :force => true do |t|
    t.text     "comment"
    t.integer  "rating",     :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plazr_store_feedback_stores", ["user_id"], :name => "index_plazr_store_feedback_stores_on_user_id"

  create_table "plazr_store_multimedia", :force => true do |t|
    t.text     "description"
    t.integer  "size"
    t.text     "link"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "page_id"
    t.integer  "variant_id"
  end

  add_index "plazr_store_multimedia", ["page_id"], :name => "index_plazr_store_multimedia_on_page_id"
  add_index "plazr_store_multimedia", ["variant_id"], :name => "index_plazr_store_multimedia_on_variant_id"

  create_table "plazr_store_orders", :force => true do |t|
    t.string   "email",                                                              :null => false
    t.decimal  "item_total",          :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "adjustment_total",    :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "total",               :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.string   "payment_state",                                                      :null => false
    t.string   "shipment_state",                                                     :null => false
    t.datetime "completed_at"
    t.string   "state",                                                              :null => false
    t.integer  "cart_id",                                                            :null => false
    t.integer  "promotional_code_id"
    t.integer  "coupon_id"
    t.integer  "payment_data_id",                                                    :null => false
    t.integer  "user_id",                                                            :null => false
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  add_index "plazr_store_orders", ["bill_address_id"], :name => "index_plazr_store_orders_on_bill_address_id"
  add_index "plazr_store_orders", ["cart_id"], :name => "index_plazr_store_orders_on_cart_id"
  add_index "plazr_store_orders", ["coupon_id"], :name => "index_plazr_store_orders_on_coupon_id"
  add_index "plazr_store_orders", ["payment_data_id"], :name => "index_plazr_store_orders_on_payment_data_id"
  add_index "plazr_store_orders", ["promotional_code_id"], :name => "index_plazr_store_orders_on_promotional_code_id"
  add_index "plazr_store_orders", ["ship_address_id"], :name => "index_plazr_store_orders_on_ship_address_id"
  add_index "plazr_store_orders", ["user_id"], :name => "index_plazr_store_orders_on_user_id"

  create_table "plazr_store_pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plazr_store_pages", ["slug"], :name => "index_plazr_store_pages_on_slug"

  create_table "plazr_store_payment_data", :force => true do |t|
    t.decimal  "total"
    t.text     "payment_data"
    t.string   "state",             :null => false
    t.integer  "user_id",           :null => false
    t.integer  "payment_method_id", :null => false
    t.integer  "bill_address_id",   :null => false
    t.integer  "ship_address_id",   :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "plazr_store_payment_data", ["bill_address_id"], :name => "index_plazr_store_payment_data_on_bill_address_id"
  add_index "plazr_store_payment_data", ["payment_method_id"], :name => "index_plazr_store_payment_data_on_payment_method_id"
  add_index "plazr_store_payment_data", ["ship_address_id"], :name => "index_plazr_store_payment_data_on_ship_address_id"
  add_index "plazr_store_payment_data", ["user_id"], :name => "index_plazr_store_payment_data_on_user_id"

  create_table "plazr_store_product_properties", :force => true do |t|
    t.string   "value",       :null => false
    t.integer  "product_id",  :null => false
    t.integer  "property_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "plazr_store_product_properties", ["product_id", "property_id"], :name => "index_product_property", :unique => true

  create_table "plazr_store_products", :force => true do |t|
    t.string   "name",                           :null => false
    t.text     "details"
    t.string   "permalink"
    t.decimal  "price_max"
    t.decimal  "price_min"
    t.decimal  "rating"
    t.boolean  "active",       :default => true, :null => false
    t.integer  "brand_id"
    t.integer  "prototype_id"
    t.datetime "available_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "plazr_store_products", ["available_at"], :name => "index_plazr_store_products_on_available_at"
  add_index "plazr_store_products", ["brand_id"], :name => "index_plazr_store_products_on_brand_id"
  add_index "plazr_store_products", ["name"], :name => "index_plazr_store_products_on_name"
  add_index "plazr_store_products", ["permalink"], :name => "index_plazr_store_products_on_permalink"
  add_index "plazr_store_products", ["prototype_id"], :name => "index_plazr_store_products_on_prototype_id"

  create_table "plazr_store_promotional_codes", :force => true do |t|
    t.string   "code",                        :null => false
    t.text     "description"
    t.string   "value",                       :null => false
    t.integer  "minimum_cart"
    t.datetime "starts_at",                   :null => false
    t.datetime "expires_at"
    t.integer  "uses_allowed", :default => 1
    t.integer  "times_used",   :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "plazr_store_promotional_codes", ["code"], :name => "index_plazr_store_promotional_codes_on_code"

  create_table "plazr_store_promotions", :force => true do |t|
    t.string   "name",             :null => false
    t.text     "description"
    t.string   "value",            :null => false
    t.datetime "starts_at",        :null => false
    t.datetime "expires_at"
    t.integer  "discount_type_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "plazr_store_promotions", ["discount_type_id"], :name => "index_plazr_store_promotions_on_discount_type_id"

  create_table "plazr_store_properties", :force => true do |t|
    t.string   "id_name"
    t.string   "display_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "plazr_store_prototypes", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plazr_store_shipment_conditions", :force => true do |t|
    t.string   "shipment_method",                               :null => false
    t.decimal  "value",           :precision => 8, :scale => 2
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "plazr_store_store_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plazr_store_user_groups", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plazr_store_variant_categories", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plazr_store_variant_properties", :force => true do |t|
    t.string   "id_name"
    t.string   "display_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "plazr_store_variant_property_values", :force => true do |t|
    t.string   "value",               :null => false
    t.integer  "variant_id",          :null => false
    t.integer  "variant_property_id", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "plazr_store_variant_property_values", ["variant_id", "variant_property_id"], :name => "index_variant_property_value", :unique => true

  create_table "plazr_store_variants", :force => true do |t|
    t.string   "sku",                                                               :null => false
    t.text     "description"
    t.decimal  "price",            :precision => 8, :scale => 2,                    :null => false
    t.decimal  "cost_price",       :precision => 8, :scale => 2
    t.boolean  "available",                                      :default => true,  :null => false
    t.integer  "amount_available",                               :default => 0,     :null => false
    t.boolean  "is_master",                                      :default => false, :null => false
    t.integer  "product_id",                                                        :null => false
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  add_index "plazr_store_variants", ["product_id"], :name => "index_plazr_store_variants_on_product_id"
  add_index "plazr_store_variants", ["sku"], :name => "index_plazr_store_variants_on_sku"

  create_table "plazr_store_wishlists", :force => true do |t|
    t.string   "name",                         :null => false
    t.boolean  "is_private", :default => true, :null => false
    t.integer  "user_id",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "plazr_store_wishlists", ["user_id"], :name => "index_plazr_store_wishlists_on_user_id"

end
