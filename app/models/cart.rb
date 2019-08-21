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

end
