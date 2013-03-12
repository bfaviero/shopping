class AddActiveToCarts < ActiveRecord::Migration
  def change
  	add_column :carts, :active, :boolean
  end
end
