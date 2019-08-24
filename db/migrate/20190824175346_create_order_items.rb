class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity
      t.float :price
      t.string :name
      t.string :merchant
      t.float :subtotal
      t.integer :merchant_id

      t.timestamps
    end
  end
end
