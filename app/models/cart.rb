class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def total_items
    num_items = @contents.values.map { |val| val.to_i }.sum
    @contents.empty? ? 0 : num_items
  end

  def quantity_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def add_item(item_id)
      @contents[item_id.to_s] = quantity_of(item_id) + 1
  end

  def subtotal(item_id)
    item = Item.find(item_id)
    @contents[item_id.to_s] * item.price
  end

  def order_total
    @contents.map { |id, qty| subtotal(id) }.sum
  end

  def create_item_orders(order, total)
    @contents.each do |item, qty|
      ItemOrder.create(order_id: order.id,
                      item_id: Item.find(item).id,
                      quantity: qty,
                      total_cost: total)
    end
  end
end
