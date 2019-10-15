class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  validates_length_of :zip, :is => 5
  validates :zip, numericality: true

  def has_orders?
    arr = []
    items.each do |item|
      if item.item_orders.count > 0
        arr << false
      end
    end
    arr.include?(false)
  end

  def count_of_items
    items.count
  end

  def average_price
    items.average(:price)
  end

  def distinct_cities
    cities_arr = []
    items.each do |item|
      cities_arr << item.orders.distinct.pluck(:customer_city)
    end
    cities_arr.flatten
  end
end
