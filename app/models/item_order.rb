class ItemOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates_presence_of :item_id,
                        :order_id

  def find(item_id, order_id)
    ItemOrder.find_by(item_id: item_id, order_id: order_id)
  end

  def self.find_all(order_id)
    item_orders = []
    ItemOrder.pluck(:item_id).each do |item_id|
      item_orders << ItemOrder.find(item_id, order_id)
    end
    item_orders
  end

  def current_item
    Item.find(item_id)
  end
end
