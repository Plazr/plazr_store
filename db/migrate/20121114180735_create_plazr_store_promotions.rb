class CreatePlazrStorePromotions < ActiveRecord::Migration
  def change
    create_table :plazr_store_promotions do |t|
      t.string :name, :null => false
      t.text :description
      t.string :value, :null => false
      t.datetime :starts_at, :null => false
      t.datetime :expires_at
      t.references :discount_type, :null => false

      t.timestamps
    end
    add_index :plazr_store_promotions, :discount_type_id
  end
end
