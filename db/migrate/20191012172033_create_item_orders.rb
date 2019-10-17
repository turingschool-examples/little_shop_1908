class CreateItemOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :item_orders do |t|
      t.integer :item_quantity
      t.float :subtotal
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
