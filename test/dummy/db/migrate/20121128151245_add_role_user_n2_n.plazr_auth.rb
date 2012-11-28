# This migration comes from plazr_auth (originally 20120829231834)
class AddRoleUserN2N < ActiveRecord::Migration

  def connection
    PlazrAuth::User.connection
  end

  def up
    create_table :plazr_auth_role_users do |t|
      t.integer :user_id
      t.integer :role_id
    end
  end

  def down
    drop_table :users_roles
  end
end
