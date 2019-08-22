class Order < ApplicationRecord
  has_many :item_orders
  validates_presence_of :name, :address, :city, :state, :zip
end
