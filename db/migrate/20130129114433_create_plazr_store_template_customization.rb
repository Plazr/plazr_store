class CreatePlazrStoreTemplateCustomization < ActiveRecord::Migration
  def change
    create_table :plazr_store_template_customizations do |t|
      t.string :id_name, :null => false
      t.string :display_name
      t.string :value, :null => false

      t.timestamps
    end
  end
end
