class CreatePlazrStorePromotionalCodes < ActiveRecord::Migration
  def change
    create_table :plazr_store_promotional_codes do |t|
      t.string :code
      t.text :description
      t.string :value
      t.integer :minimum_cart
      t.datetime :starts_at
      t.datetime :expires_at
      t.integer :uses_allowed

      t.timestamps
    end
  end
end
