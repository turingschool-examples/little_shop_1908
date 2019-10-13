class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city
  validates :city, format: { with: /\A[a-zA-Z]+\z/ }
  validates_presence_of :state
  validates :state, format: { with: /\A[a-zA-Z]+\z/ }
  validates :state, length: { in: 2..15 }
  validates_presence_of :zip
  validates :zip, numericality: true
  validates :zip, length: { is: 5 }

end
