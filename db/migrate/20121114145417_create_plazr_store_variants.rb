class CreatePlazrStoreVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_variants do |t|
      t.string :sku, :null => false
      t.text :description
      t.date :restock_date
      t.decimal :price, :null => false, :precision => 8, :scale => 2
      t.decimal :cost_price, :precision => 8, :scale => 2
      t.boolean :visible, :null => false, :default => true
      t.integer :amount_available, :null => false, :default => -1
      t.boolean :is_master, :null => false, :default => false
      t.references :product, :null => false
      # t.datetime :deleted_at

      t.timestamps
    end
    add_index :plazr_store_variants, :product_id
    add_index :plazr_store_variants, :sku
  end
end
