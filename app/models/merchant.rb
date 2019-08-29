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
    items.count
  end

  def avg_price
    items.average(:price)
  end

  def shipped_to_cities
    Order.where(id: item_orders.pluck(:order_id))
    .distinct
    .pluck(:city)
  end
end
