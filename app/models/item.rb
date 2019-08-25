class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :image
  validates_inclusion_of :active?, :in => [true, false]
  validates :price, numericality: {only_integer: true}
  validates :inventory, numericality: {only_integer: true}

  def avg_rating
    reviews.average(:rating)
  end

  def best_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    reviews.order(:rating).limit(3)
  end

  def buy
    if self.inventory > 0
      self.inventory -= 1
    end
    if self.inventory <= 0
      self.update(active?: false)
    end
    self.save
  end

  def restock
    self.update(active?: true) if self.inventory > 0
  end

  def restock_qty(qty)
    self.inventory += qty
    self.save
  end
end
