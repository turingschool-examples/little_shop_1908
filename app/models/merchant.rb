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


end
