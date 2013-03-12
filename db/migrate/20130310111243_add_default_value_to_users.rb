class AddDefaultValueToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :temp, :boolean, :default => false
  end
end
