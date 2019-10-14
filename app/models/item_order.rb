class ItemOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates_presence_of :item_id,
                        :order_id

  def current_item
    Item.find(item_id)
  end
end
