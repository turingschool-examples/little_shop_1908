class Cart
  attr_reader :contents

  def initialize(item_hash)
    @contents = item_hash ||= Hash.new(0)
  end

  def add_item(item_id)
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end

  def total_count
    @contents.values.sum
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def grand_total
    grand_total = 0
    @contents.each do |id, quantity|
      grand_total += Item.find(id).subtotal(id, quantity)
    end
    grand_total
  end
end
