class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def add_item(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def total_count
    @contents.values.sum
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      grand_total += Item.find(item_id).price * quantity
    end
    grand_total
  end

  def actual_items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def subtotal(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def remove_item(item_id)
    @contents[item_id.to_s] -= 1
  end

  def limit?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

end
