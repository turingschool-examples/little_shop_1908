class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state
  validates :zip, numericality: {only_integer: true}
end
