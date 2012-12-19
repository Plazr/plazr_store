# This migration comes from plazr_auth (originally 20121218142552)
class CreatePlazrAuthPaypalAccounts < ActiveRecord::Migration
  def connection
    PlazrAuth::User.connection
  end
  
  def change
    create_table :plazr_auth_paypal_accounts do |t|
      t.integer :store_id
      t.string :api_password 
      t.string :api_username
      t.string :signature
      t.datetime :deleted_at
    end
  end
end
