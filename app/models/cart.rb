class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item_id)
    # item_id must be a string to reference @contents hash correctly
    @contents[item_id] = @contents[item_id] + 1
  end

  def count_of(item_id)
    @contents[item_id].to_i
  end
end
