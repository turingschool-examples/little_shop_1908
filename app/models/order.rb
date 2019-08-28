class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  before_create :generate_order_key

  private
  def generate_order_key
    self.order_key = rand(10 ** 10).to_s.rjust(10, "0")
  end
end
