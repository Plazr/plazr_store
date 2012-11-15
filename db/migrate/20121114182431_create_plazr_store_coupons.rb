class CreatePlazrStoreCoupons < ActiveRecord::Migration
  def change
    create_table :plazr_store_coupons do |t|
      t.string :code
      t.text :description
      t.string :value
      t.integer :minimum_cart
      t.datetime :starts_at
      t.datetime :expires_at
      t.integer :uses_allowed
      t.references :discount_type
      t.references :user

      t.timestamps
    end
    add_index :plazr_store_coupons, :discount_type_id
    add_index :plazr_store_coupons, :user_id
  end
end
