class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def add_item(id)
    @contents[id.to_s] += 1
  end

  def decrease_item(id)
    @contents[id.to_s] -= 1
    @contents.delete_if {|item_id, quantity| quantity <= 0}
  end

end
