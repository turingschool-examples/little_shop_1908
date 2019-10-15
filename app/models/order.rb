class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders

  def date
    self.created_at.strftime("%m/%d/%Y")
  end
end
