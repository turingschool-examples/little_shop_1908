class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def cart_items
    new_items = Hash.new(0)
    @contents.each do |id, quantity|
      new_items[Item.find(id)] = quantity
    end
    new_items
  end

  def grand_total
    total = 0
    cart_items.each do |item, quantity|
      total += (item.price * quantity)
    end
    total 
  end
end
