class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def has_orders?
    ItemOrder.joins(:item)
    .where("items.merchant_id = #{self.id}")
    .count > 0
  end
end
