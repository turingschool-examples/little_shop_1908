class Merchant <ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def has_items_ordered
    ids = Item.joins(:item_orders).pluck(:merchant_id)
    if ids.include?(self.id)
      true
    else false
    end
  end

end
