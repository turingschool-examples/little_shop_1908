class Merchant <ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def sold_items?
    merchants = OrderItem.all.pluck(:merchant_id)
    merchants.include?(self.id)
    #use more ActiveRecord on refactor - joins tables together to see if they're empty or not
  end

end
