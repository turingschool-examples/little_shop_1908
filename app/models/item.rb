class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def top_reviews
    reviews.order(rating: :desc).limit(3).pluck(:title, :rating)
  end

  def bottom_reviews
    reviews.order(:rating).limit(3).pluck(:title, :rating)
  end

  def average_rating
    reviews.average(:rating)
  end

  def lowest_reviews
    reviews.order(:rating)
  end

  def highest_reviews
    reviews.order(rating: :desc)
  end

end
