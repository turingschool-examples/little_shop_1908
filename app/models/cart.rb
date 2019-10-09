class Cart
  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def count
    @contents.values.sum
  end
end
