class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def quantity_of_item(item_id)
    item_orders.where(item_id: item_id).pluck(:item_quantity).first
  end

  def subtotal_of_item(item_id)
    price = item_orders.where(item_id: item_id).pluck(:item_price).first
    price * quantity_of_item(item_id)
  end

  def grand_total
    our_item_orders = item_orders.all
    our_item_orders.reduce(0) do |sum, item_order|
      sum + subtotal_of_item(item_order.item_id)
    end
  end
end
