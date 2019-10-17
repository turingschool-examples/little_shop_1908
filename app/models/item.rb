class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, in: [true, false]

  validates_numericality_of :price
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, only_integer: true
  validates_numericality_of :inventory, greater_than: 0

  def self.total_count
    count
  end

  def self.average_price
    average(:price)
  end

  def self.top_three
    joins(:reviews)
      .group('items.id')
      .order('avg(reviews.rating) DESC')
      .limit(3)
  end

end
