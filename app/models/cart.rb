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
    @contents[item_id.to_s] = @contents[item_id.to_s] + 1
  end

  def count_of(item_id)
    @contents[item_id.to_s].to_i ||= 0
  end

  def subtotal(item_id)
    item = Item.find(item_id)
    price = item.price
    quantity = count_of(item_id)
    price * quantity
  end

  def grand_total
    @contents.reduce(0) do |sum, (item_id, _)|
      sum + subtotal(item_id)
    end
  end

  def empty_cart
    @contents = {}
  end
end
