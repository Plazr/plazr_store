class CreatePlazrStoreConditions < ActiveRecord::Migration
  def change
    create_table :plazr_store_conditions do |t|
      t.string :condition, :null => false
      t.references :category_condition

      t.timestamps
    end
    add_index :plazr_store_conditions, :category_condition_id
  end
end
