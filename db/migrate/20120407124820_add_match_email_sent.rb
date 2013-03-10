class AddMatchEmailSent < ActiveRecord::Migration
  def change
    add_column :users, :match_email_sent, :boolean, :default => false
  end
end
