class Merchant < ApplicationRecord
  has_many :items
  has_many :items, :dependent => :destroy
  has_many :order_items, through: :items
  
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip



  def average_item_price
    items.average(:price)
  end

  def cities
    order_items.distinct.joins(:order).pluck(:city)
  end
end
