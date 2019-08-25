# does NOT inherit from ApplicationRecord because it's a PORO!
class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def item_quantity
    @contents.map do |key, value|
      [Item.find(key.to_i), value]
    end.to_h
  end

  def total_count
    @contents.values.sum
  end

  def add_item(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def total
    @contents.sum do |item_id, quantity|
      Item.find(item_id).price * quantity
    end
  end

  def has_items?
    !@contents.nil?
  end
end
