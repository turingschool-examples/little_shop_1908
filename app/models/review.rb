class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :content,
                        :rating

  validates_numericality_of :rating,  only_integer: true,
                                      less_than_or_equal_to: 5,
                                      greater_than_or_equal_to: 1

  def self.top
    Review.order(:rating).limit(3)
  end

  def self.bottom
    Review.order(rating: :desc).limit(3)
  end

  def self.avg_rating
    Review.average(:rating).round(2)
  end

end
