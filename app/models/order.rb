class Order <ApplicationRecord

  has_many :items_orders
  has_many :items, through: :items_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def show_subtotal(itemorder, item)
    (itemorder.quantity * item.price)
  end

  def show_grand_total
    subtotals = []
    item_ids = items_orders.pluck(:item_id)
      items_orders.each_with_index do |itemorder, i|
        item = Item.find(item_ids[i])
        subtotals << show_subtotal(itemorder, item)
      end
      subtotals.sum
    end

  end
