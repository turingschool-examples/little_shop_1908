class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :content,
                        :rating

  def self.top_or_bottom_three(item_id, order = :desc)
    where(item_id: item_id)
      .order(rating: order)
      .limit(3)
  end

  def
end
