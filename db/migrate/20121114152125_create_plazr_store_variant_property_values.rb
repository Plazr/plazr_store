class CreatePlazrStoreVariantPropertyValues < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_property_values do |t|
      t.string :value

      t.timestamps
    end
  end
end
