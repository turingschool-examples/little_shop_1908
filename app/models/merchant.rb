class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  validates_numericality_of :zip, only_integer: true
  validates_length_of :zip, is: 5

  def orders
    orders = Order.where(id: ItemOrder.where(item_id: items.pluck(:id)).pluck(:order_id))
  end
end
