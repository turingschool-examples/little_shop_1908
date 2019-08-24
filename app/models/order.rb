class Order < ApplicationRecord

  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def grand_total
    order_items.map do |order_item|
      order_item.subtotal
    end.sum
  end

end
