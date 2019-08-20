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
  if self.inventory > 0
    self.update(active?: true)
  end
end

end
