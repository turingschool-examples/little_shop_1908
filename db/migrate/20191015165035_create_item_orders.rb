class CreateItemOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :item_orders do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity
    end
  end
end
