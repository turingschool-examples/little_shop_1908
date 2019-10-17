class OrderDisplay
  attr_reader :order, :order_id

  def initialize(order_id)
    @order_id = order_id
    @order = Order.find(order_id)
  end

  def items
    @order.items
  end

  def quantity_of_item(item_id)
    @order.item_orders.find_by(item_id: item_id).item_quantity
  end

  def subtotal_of_item(item_id)
    @order.item_orders.find_by(item_id: item_id).subtotal
  end

  def grand_total
    @order.grand_total
  end

  def verification_code
    @order.verification_code
  end

  def user_id
    @order.user_id
  end

  def user_name
    @order.user.name
  end

  def user_address
    @order.user.address
  end

  def user_city
    @order.user.city
  end

  def user_state
    @order.user.state
  end

  def user_zip
    @order.user.zip
  end

end
