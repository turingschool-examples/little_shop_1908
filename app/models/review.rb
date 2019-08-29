class Review <ApplicationRecord
  belongs_to :item
  validates_presence_of :title,
                        :content,
                        :rating
  validates_inclusion_of :rating, in: (1..5)
end
