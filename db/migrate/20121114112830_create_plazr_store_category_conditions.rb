class CreatePlazrStoreCategoryConditions < ActiveRecord::Migration
  def change
    create_table :plazr_store_category_conditions do |t|
      t.string :description

      t.timestamps
    end
  end
end
