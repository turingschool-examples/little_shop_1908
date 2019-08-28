class Merchant < ApplicationRecord
  has_many :items
  has_many :item_orders, through: :items
  has_many :reviews, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def num_products
    self.items.count
  end

  def avg_price
    self.items.average(:price)
  end

  def shipped_to_cities
    cities = []
    self.items.each do |item|
      item.item_orders.each do |item_order|
         cities << item_order.order.city
      end
    end
    cities.uniq.join(", ")
  end
end
