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
    if num_products > 0
      price_sum = self.items.sum do |item|
        item.price
      end/num_products
    end
  end

  def shipped_to_cities
    order(rating: :asc).limit(3)
  end
end
