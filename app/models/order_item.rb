class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  validates_presence_of :quantity,
                        :price,
                        :name,
                        :merchant,
                        :subtotal
end
