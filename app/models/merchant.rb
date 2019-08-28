class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :orders, through: :item_orders
  has_many :reviews, through: :items

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

  def best_items
    Merchant.joins(:reviews)
      .select("items.id, items.name, avg(reviews.rating)")
      .where("merchants.id = #{self.id}")
      .group("items.id")
      .order("avg desc")
      .limit(3)
  end
end
