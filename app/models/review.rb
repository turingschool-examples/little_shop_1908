class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :rating,
                        :content
end
