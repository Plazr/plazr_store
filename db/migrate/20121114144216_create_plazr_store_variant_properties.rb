class CreatePlazrStoreVariantProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_properties do |t|
      t.string :id_name
      t.string :display_name, :null => false

      t.timestamps
    end
  end
end
