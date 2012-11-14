class CreatePlazrStorePromotions < ActiveRecord::Migration
  def change
    create_table :plazr_store_promotions do |t|
      t.string :name
      t.text :description
      t.string :value
      t.datetime :starts_at
      t.datetime :expires_at
      t.references :discount_type

      t.timestamps
    end
    add_index :plazr_store_promotions, :discount_type_id
  end
end
