class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  # def cart_items
  #   array_thing = []
  #   @contents.keys.each do |id|
  #     array_thing << Item.find(id)
  #   end
  #   array_thing
  # end

end
