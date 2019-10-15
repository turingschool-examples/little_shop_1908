class Order < ApplicationRecord
  validates_presence_of :grand_total

  validates_numericality_of :grand_total
  validates_numericality_of :grand_total, greater_than: 0

  has_many :item_orders
  has_many :items, through: :item_orders

  belongs_to :user

  def self.distinct_cities
    joins(:user).distinct.pluck(:city, :state)
  end
end
