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
    ItemOrder.left_outer_joins(:order).where(item_id: items).pluck(:city).uniq
  end

  def highest_rated_items
    rated_items = items.select { |item| item.reviews.empty? == false }.sort_by { |item| item.average_rating}.reverse
  end
end
