class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews

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

end
