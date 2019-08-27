class Order < ApplicationRecord

  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def self.order_details(order_id)
    select(where(id: [order_id]))
  end
end
