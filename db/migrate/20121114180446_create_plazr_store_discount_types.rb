class CreatePlazrStoreDiscountTypes < ActiveRecord::Migration
  def change
    create_table :plazr_store_discount_types do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :scope 

      t.timestamps
    end
  end
end
