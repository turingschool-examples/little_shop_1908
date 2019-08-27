class ItemOrder < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :quantity,
                        :subtotal

end
