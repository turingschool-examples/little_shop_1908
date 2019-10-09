class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :rating
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
end
