class Order < ApplicationRecord

  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def self.order_details
    select()
    # self.map do |order|
    #   [Item.find(key.to_i), value]
    # end.to_h
  end
end
