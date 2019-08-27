class AddTimestampsToItemOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :item_orders, :created_at, :datetime
    add_column :item_orders, :updated_at, :datetime
  end
end
