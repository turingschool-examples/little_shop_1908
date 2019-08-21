class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :rating

  def self.avg_rating
      average(:rating)
  end
end
