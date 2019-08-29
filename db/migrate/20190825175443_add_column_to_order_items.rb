class AddColumnToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :price, :float
    add_column :order_items, :created_at, :datetime
    add_column :order_items, :updated_at, :datetime
  end
end
