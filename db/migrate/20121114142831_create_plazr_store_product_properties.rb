class CreatePlazrStoreProductProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_properties do |t|
      t.string :value

      t.timestamps
    end
  end
end
