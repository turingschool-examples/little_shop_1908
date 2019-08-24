class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents ||= Hash.new(0)
    @contents.default = 0
  end

  def add_item(item)
    @contents[item.to_s] +=  1
  end

  def subtract_item(item)
    @contents[item.to_s] -= 1
    if @contents[item.to_s] < 1
      delete_item(item)
    end
  end

  def delete_item(item)
    @contents.delete(item.to_s)
  end

  def quantity_of(item)
    @contents[item.id.to_s]
  end

  def available_inventory?(item)
    @contents[item.id.to_s] < item.inventory
  end

  def subtotal(item)
    quantity_of(item) * item.price
  end

  def total_count
    @contents.values.sum
  end

  def grand_total
    @contents.map do |item_id, quantity|
      a = Item.find(item_id)
      a.price * quantity
    end.sum
  end

  def items
    @contents.keys.map do |item_id|
      Item.find(item_id)
    end
  end

end
