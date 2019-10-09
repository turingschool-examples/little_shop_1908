class Cart
  attr_reader :contents

  def initialize(items_hash)
    @contents = items_hash ||= {}
  end

  def add_item(item)
    @contents[item] ||= 0
    @contents[item] += 1
  end

  def total_count
    @contents.values.sum
  end

end
