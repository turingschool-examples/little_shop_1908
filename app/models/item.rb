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
    Item.where(id: id).empty?
  end

  def has_orders?
    orders.count > 0
  end

end
