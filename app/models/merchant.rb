class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state
  validates :zip, numericality: {only_integer: true}

  def has_items_ordered
    ids = Item.joins(:item_orders).pluck(:merchant_id)
    ids.include?(self.id)
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def cities_serviced
    Item.joins(:orders).distinct.pluck(:city)
  end
end
