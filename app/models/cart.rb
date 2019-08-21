class Cart
  attr_accessor :contents

  def initialize(initial_contents)
    # if contents
    #   @contents = contents
    # else
    #   @contents = {}
    # end
    @contents = initial_contents || Hash.new(0)
  end

  def add_item(item)
    @contents[item.to_s] = quantity_of(item) + 1
  end

  def quantity_of(item)
    @contents[item.to_s].to_i
  end

  def total_count
    @contents.values.sum
  end

end
