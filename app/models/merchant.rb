class Merchant <ApplicationRecord
  has_many :items
  has_many :item_orders, through: :items
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def has_item_orders?
    !item_orders.empty?
  end

  def number_of_items
    items.count
  end

  def avg_price
    items.average(:price)
  end

  def all_cities
    orders.pluck(:city).uniq.sort
  end
end
