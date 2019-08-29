class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def self.cart_items(cart)
    Item.where(id: [cart.contents.keys])
  end

  def self.exists?(id)
    !Item.where(id: id).empty?
  end

  def has_orders?
    orders.count > 0
  end

  def top_or_bottom_3_reviews(order: :desc)
    reviews.order(rating: order).limit(3)
  end

  def average_rating
    reviews.average(:rating)
  end

  def sort_reviews(method)
    revs = reviews
    if method == 'max-rating'
      revs.order(rating: :desc, created_at: :desc)
    elsif method == 'min-rating'
      revs.order(rating: :asc, created_at: :desc)
    elsif method == 'date-asc'
      revs.order(created_at: :asc)
    else
      revs.order(created_at: :desc)
    end
  end
end
