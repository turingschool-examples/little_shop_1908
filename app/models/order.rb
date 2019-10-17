class Order < ApplicationRecord
  validates_presence_of :grand_total
  validates_presence_of :verification_code

  validates_numericality_of :grand_total
  validates_numericality_of :grand_total, greater_than: 0

  validates_numericality_of :verification_code, only_integer: true
  validates_length_of :verification_code, is: 10
  validates :verification_code, uniqueness: true

  has_many :item_orders
  has_many :items, through: :item_orders

  belongs_to :user

  def self.distinct_cities
    joins(:user).distinct.pluck(:city, :state)
  end
end
