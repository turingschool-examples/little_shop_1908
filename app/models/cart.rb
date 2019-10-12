class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def cart_items
    new_items = []
    @contents.keys.each do |id|
      new_items << Item.find(id)
    end
     new_items
  end

  def quantities
    new_quantity = []
    @contents.values.each do |value|
      new_quantity << value
    end
    new_quantity
  end
end
