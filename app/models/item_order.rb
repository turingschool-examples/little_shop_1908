class ItemOrder < ApplicationRecord
  validates_presence_of :item_quantity,
                        :subtotal

  belongs_to :item
  belongs_to :order
end