class Review < ApplicationRecord
  validates_presence_of :title,
                        :content,
                        :rating

  validates_numericality_of :rating, only_integer: true
  validates_numericality_of :rating, greater_than_or_equal_to: 1
  validates_numericality_of :rating, less_than_or_equal_to: 5

  belongs_to :item

  def self.top_three
    order(rating: :desc).limit(3)
  end

  def self.bottom_three
    order(:rating).limit(3)
  end

  def self.average_rating
    average(:rating)
  end

end
