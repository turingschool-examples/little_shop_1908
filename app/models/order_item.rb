class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  validates_presence_of :order,
                        :item,
                        :price,
                        :quantity

end
