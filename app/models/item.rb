class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews

  validates_presence_of :name,
                        :description,
                        :price
  validates :price, numericality: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates_presence_of :image,
                        :inventory
  validates :inventory, numericality: true
  validates :inventory, numericality: { greater_than_or_equal_to: 1 }
  validates_inclusion_of :active?, :in => [true, false]



end
