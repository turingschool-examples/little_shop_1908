class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents ||= Hash.new(0)
    @contents.default = 0
  end

  def add_item(item)
    # binding.pry
    @contents[item.to_s] +=  1
  end

  def quantity_of(item)
    @contents[item.to_s]
  end

  def total_count
    @contents.values.sum
  end

  def items
    @contents.keys.map do |item_id|
      Item.find(item_id)
    end
  end

end
