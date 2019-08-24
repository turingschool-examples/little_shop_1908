class Merchant < ApplicationRecord
  has_many :items
  has_many :reviews, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

end
