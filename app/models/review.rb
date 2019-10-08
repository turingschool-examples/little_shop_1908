class Review < ApplicationRecord
  validates_presence_of :title, :content, :rating
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
