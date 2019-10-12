class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def add_item(id)
    @contents[id.to_s] += 1
  end

  def subtract_item(id)
    @contents[id.to_s] -= 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def cart_items
    items = []
    @contents.keys.each do |item_id|
      items << Item.find(item_id)
    end
    items
  end

  def subtotal(id)
    count_of(id) * Item.find(id).price
  end

  def grand_total
    @contents.keys.sum do |item_id|
      subtotal(item_id)
    end
  end
end
