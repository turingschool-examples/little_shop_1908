class Merchant <ApplicationRecord
  has_many :items, :dependent => :destroy
  has_many :items_orders, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def total_items_count
    items.count
  end

  def average_price_items
    items.average(:price)
  end

  def list_cities
    order_ids = items_orders.pluck(:order_id)
    Order.where(id: order_ids).pluck("DISTINCT city")
  end

end
