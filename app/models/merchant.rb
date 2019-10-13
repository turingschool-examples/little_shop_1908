class Merchant <ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def average_item_price
    if items.empty?
      return
    else
      items.average(:price).round(2)
    end 
  end

  def distinct_cities
    order_ids = items.map do |item|
      ItemOrder.where(item_id: item.id).pluck(:order_id)
    end.flatten

    Order.where(id: order_ids).pluck(:city).uniq
  end
end
