class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :item
      t.references :cart
      t.integer :quantity

      t.timestamps
    end
    add_index :line_items, :item_id
    add_index :line_items, :cart_id
  end
end
