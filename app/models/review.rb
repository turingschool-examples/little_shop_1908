class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :rating
  # VALIDATIONS THAT RATING IS NUMERIC AND BETWEEN 1-5
  # VIEW SHOULDA MATCHERS DOC - ACTIVEMODEL MATCHERS

  def self.avg_rating
      average(:rating)
  end

  def self.top_three_reviews

    order(rating: :asc).last(3)
  end

  def self.bottom_three_reviews
    order(rating: :asc).first(3)
  end
end
