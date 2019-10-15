class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title, :content, :rating

  def best_review_display
    @reviews = Review.order(rating: :desc, created_at: :desc)
  end

  def worst_review_display
    @reviews = Review.order(:rating, created_at: :desc)
  end
end
