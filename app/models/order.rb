class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :grand_total,
                        :verification

  def generate_item_orders(cart)
    cart.cart_items.each do |item|
      ItemOrder.create( order_id: id,
                        item_id: item.id,
                        quantity: cart.count_of(item.id),
                        subtotal: (cart.count_of(item.id) * item.price)
                      )
    end
  end

  def self.generate_code
    number = SecureRandom.hex(5)
    until !Order.pluck(:verification).include?(number)
      number = SecureRandom.hex(5)
    end
    number
  end
end
