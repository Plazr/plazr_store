class CreatePlazrStoreProductProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_properties do |t|
      t.string :value, :null => false

      t.timestamps
    end
  end
end
