class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def avg_rating
    self.reviews.average(:rating)
  end

  def best_reviews
    self.reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    self.reviews.order(:rating).limit(3)
  end

end
