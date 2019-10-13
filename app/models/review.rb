class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :content,
                        :rating
  validates :rating, numericality: true
  validates :rating, numericality: { greater_than_or_equal_to: 1 }
  validates :rating, numericality: { less_than_or_equal_to: 5 }

  def self.top_reviews
    order(rating: :desc).limit(3)
  end

  def self.bottom_reviews
    order(:rating).limit(3)
  end

  def self.average_review
    average(:rating).to_i
  end


end
