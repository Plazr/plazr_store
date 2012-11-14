class CreatePlazrStoreVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_variants do |t|
      t.string :sku
      t.string :description
      t.decimal :price
      t.decimal :cost_price
      t.boolean :available
      t.integer :amount_available
      t.boolean :is_master
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
