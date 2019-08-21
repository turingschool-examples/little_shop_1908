class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def total_items
    num_items = @contents.values.map { |val| val.to_i }.sum
    @contents.empty? ? 0 : num_items
  end

end
