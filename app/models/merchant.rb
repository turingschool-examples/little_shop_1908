class Merchant <ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def has_item_orders?
    checks = items.map do |item|
      ItemOrder.where(item_id: item.id).any?
    end
    return true if checks.include?(true)
    return false
  end
end
