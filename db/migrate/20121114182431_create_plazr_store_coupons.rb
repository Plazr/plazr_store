class CreatePlazrStoreCoupons < ActiveRecord::Migration
  def change
    create_table :plazr_store_coupons do |t|
      t.string :code, :null => false
      t.text :description
      t.string :value, :null => false
      t.integer :minimum_cart
      t.datetime :starts_at, :null => false
      t.datetime :expires_at
      t.integer :uses_allowed, :default => 1
      t.integer :times_used, :default => 0
      t.references :discount_type, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :plazr_store_coupons, :discount_type_id
    add_index :plazr_store_coupons, :user_id
    add_index :plazr_store_coupons, :code
  end
end
