class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, :dependent => :destroy
  has_many :items_orders
  has_many :orders, through: :items_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

end


# def remove_inventory(cart_items)
#   loop to find item ids and remove those from items table
# end

# def add_inventory(cart_items)
#   loop to get id and return to items table
# end
