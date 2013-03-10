class AddEmailSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_sent, :boolean, :default => false
  end
end
