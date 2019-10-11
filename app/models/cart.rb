class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def decrease_quantity_of(item_id)
    @contents[item_id.to_s] -= 1
  end

  def total_count
    @contents.values.sum
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal(item_id)
    Item.find(item_id).price * count_of(item_id)
  end

  def grand_total
    items = Item.where(id: @contents.keys)
    items.sum { |item| item.price * count_of(item.id) }
  end

  def empty_contents
    @contents = Hash.new(0)
  end

  def remove_item(item_id)
    @contents.delete(item_id.to_s)
  end

  def decrease_or_remove_item(item_id)
    if count_of(item_id) > 1
      decrease_quantity_of(item_id)
    else
      remove_item(item_id)
    end
  end

end
