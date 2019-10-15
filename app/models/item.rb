class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def top_three_reviews
    reviews.order("rating desc").limit(3)
  end

  def bottom_three_reviews
    reviews.order('rating').limit(3)
  end

  def average_rating
    reviews.average(:rating).round(2)
  end

  def order_item(order_id)
    item_orders.where("order_id = #{order_id.to_s} and item_id = #{self.id}").first
  end

  def sort_reviews(sort)
    if sort.nil?
      @reviews = reviews
    elsif sort == 'highest'
      @reviews = reviews.order(rating: :desc, created_at: :desc)
    elsif sort == 'lowest'
      @reviews = reviews.order(:rating, :created_at)
    end
  end
end
