# This migration comes from plazr_auth (originally 20120827100215)
class CreatePlazrAuthRoles < ActiveRecord::Migration

  def connection
    PlazrAuth::User.connection
  end

  def change
    create_table :plazr_auth_roles do |t|

      t.string :name, :null => false
      t.string :desc
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
