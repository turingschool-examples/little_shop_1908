class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :item_id,
                        :order_id,
                        :quantity,
                        :price

end
