class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders
  validates_presence_of :name, :address, :city, :state, :zip

  def create_item_orders(cart)
    total = cart.order_total
    cart.contents.each do |item, qty|
      ItemOrder.create(order_id: self.id,
                      item_id: item,
                      quantity: qty,
                      total_cost: total)
    end
  end
end
