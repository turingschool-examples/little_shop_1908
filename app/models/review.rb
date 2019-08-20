class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :content,
                        :rating

  def self.average_review_rating
    average(:rating)
  end
end
