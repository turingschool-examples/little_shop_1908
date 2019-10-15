class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  validates :price, numericality: {greater_than: 0}

  # validate image link

  def top_three_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def bottom_three_reviews
    reviews.order(rating: :asc).limit(3)
  end

  def average_review_rating
    reviews.average(:rating)
  end

  def ordered?
    !orders.empty?
  end
end
