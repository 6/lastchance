class AddChoicesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :choice_1, :integer, :default => nil
    add_column :users, :choice_2, :integer, :default => nil
    add_column :users, :choice_3, :integer, :default => nil
    add_column :users, :choice_4, :integer, :default => nil
    add_column :users, :choice_5, :integer, :default => nil
    add_column :users, :choice_6, :integer, :default => nil
    add_column :users, :choice_7, :integer, :default => nil
    add_column :users, :choice_8, :integer, :default => nil
    add_column :users, :choice_9, :integer, :default => nil
    add_column :users, :choice_10, :integer, :default => nil
  end
end
