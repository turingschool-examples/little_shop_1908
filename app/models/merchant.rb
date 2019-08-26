class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def has_orders?
    item_orders.count > 0
  end

  def count_items
    items.count
  end

  def average_price
    items.average(:price)
  end

  def distinct_cities
    orders.distinct
      .order(:city)
      .pluck(:city)
  end
end
