class ItemOrder < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :order_id,
                        :item_id,
                        :quantity,
                        :subtotal
                        :created_at
                        :updated_at
end
