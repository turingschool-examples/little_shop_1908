class Merchant <ApplicationRecord
  has_many :items, :dependent => :destroy
  has_many :items_orders, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

end
