class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :content,
                        :rating

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
