class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def top_three_reviews
    self.reviews.order("reviews desc").limit(3)
  end

  def bottom_three_reviews
    self.reviews.order(:reviews).limit(3)
  end

  def average_rating
    
  end
end
