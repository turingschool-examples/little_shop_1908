class Order <ApplicationRecord

  has_many :items_orders
  has_many :items, through: :items_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

end
