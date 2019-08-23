class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :rating

  def self.avg_rating
      average(:rating)
  end

  def self.top_three_reviews

    order(rating: :desc).limit(3)
  end

  def self.bottom_three_reviews
    order(rating: :asc).limit(3)
  end
end
