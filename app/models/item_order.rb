class ItemOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end
end
