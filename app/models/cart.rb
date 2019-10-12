class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item_id)
    # item_id must be a string to reference @contents hash correctly
    @contents[item_id] = @contents[item_id] + 1
  end

  def count_of(item_id)
    @contents[item_id].to_i ||= 0
  end

  def subtotal(item_id)
    item = Item.find(item_id)
    price = item.price
    quantity = count_of(item_id)
    price * quantity
  end
end
