class Order < ApplicationRecord

  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def order_details

    item_orders = ItemOrder.where('order_id' => self.id)

    order_details = item_orders.each_with_object({}) do |item, hash|
                      hash[Item.find(item.item_id)] = item.quantity
                    end
  end

  def order_total
    self.order_details.sum do |item, quantity|
      Item.find(item.id).price * quantity
    end
  end
end
