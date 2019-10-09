class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title
  validates_presence_of :content
  validates_inclusion_of :rating, :in => [1, 2, 3, 4, 5]
end
