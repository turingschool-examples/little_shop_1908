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
    item_orders.sum('item_price * item_quantity')
  end
end
