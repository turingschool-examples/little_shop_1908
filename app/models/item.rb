class Item <ApplicationRecord
  belongs_to :merchant
  has_many :order_items, :dependent => :destroy
  has_many :orders, through: :order_items
  has_many :reviews, :dependent => :destroy
  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory

  validates_inclusion_of :active?, in: [true, false]

  def sort_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end


  def has_orders?
    id = orders.pluck(:item_id)
    if id[0] == nil
      true
    else
      false
    end
  end
end
