class CreatePlazrStoreFeedbackProducts < ActiveRecord::Migration
  def change
    create_table :plazr_store_feedback_products do |t|
      t.text :comment
      t.decimal :rating
      t.references :user
      t.references :product

      t.timestamps
    end
    add_index :plazr_store_feedback_products, :user_id
    add_index :plazr_store_feedback_products, :product_id
  end
end
