class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title,
                        :rating,
                        :content

#https://github.com/thoughtbot/shoulda-matchers/blob/master/lib/shoulda/matchers/active_model/validate_numericality_of_matcher.rb
  validates_numericality_of :rating,
                                    only_integer: true,
                                    less_than: 6,
                                    greater_than: 0

    def self.top_three
      order(rating: :desc).limit(3)
    end

    def self.bottom_three
      order(:rating).limit(3)
    end

    def self.total_average
      average(:rating)
      # binding.pry
    end
end
