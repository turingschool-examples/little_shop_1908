class ItemOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates_presence_of :item_price
  validates_presence_of :item_quantity
end
