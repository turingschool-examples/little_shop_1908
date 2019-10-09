class Cart
  attr_reader :contents

  def initialize(item_hash)
    @contents = item_hash ||= Hash.new(0)
  end

  def add_item(item)
    @contents[item] ||= 0
    @contents[item] += 1
  end

  def total_count
    @contents.values.sum
  end

end
