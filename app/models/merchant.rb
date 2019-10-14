class Merchant <ApplicationRecord
  has_many :items, :dependent => :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def items_in_order?
    !items.joins(:item_orders).empty?
  end
end
