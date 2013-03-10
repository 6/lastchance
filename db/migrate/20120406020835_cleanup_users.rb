class CleanupUsers < ActiveRecord::Migration
  def change
    drop_table :authentications
    remove_column :users, :crypted_password
    remove_column :users, :remember_me_token
    remove_column :users, :remember_me_token_expires_at
  end
end
