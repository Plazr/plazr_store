class CreatePlazrStorePromotionalCodes < ActiveRecord::Migration
  def change
    create_table :plazr_store_promotional_codes do |t|
      t.string :code, :null => false
      t.text :description
      t.string :value, :null => false
      t.integer :minimum_cart
      t.datetime :starts_at, :null => false
      t.datetime :expires_at
      t.integer :uses_allowed, :default => 1
      t.integer :times_used, :default => 0

      t.timestamps
    end
    add_index :plazr_store_promotional_codes, :code
  end
end
