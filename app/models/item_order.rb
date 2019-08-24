class ItemOrder < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :item_id
  validates_presence_of :order_id
  validates_presence_of :quantity
  validates_presence_of :total_cost
end
