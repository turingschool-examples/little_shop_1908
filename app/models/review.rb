class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :content
  validates :rating, numericality: {only_integer: true,
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 5}

  def self.top_or_bottom_three(item_id, order = :desc)
    where(item_id: item_id)
      .order(rating: order)
      .limit(3)
  end

  def self.average_rating(item_id)
    where(item_id: item_id)
      .average(:rating)
  end

  def self.sort_reviews(method, item_id)
    item = Item.find(item_id)
    reviews = item.reviews
    if method == 'max-rating'
      reviews.order(rating: :desc, created_at: :desc)
    elsif method == 'min-rating'
      reviews.order(rating: :asc, created_at: :desc)
    elsif method == 'date-asc'
      reviews.order(created_at: :asc)
    else
      reviews.order(created_at: :desc)
    end
  end

end
