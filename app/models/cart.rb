class Cart
  attr_reader :contents

  def initialize(contents)
    if contents
      @contents = contents
    else
      @contents = {}
    end
  end

  def quantity_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def add_item(item_id)
    @contents[item_id.to_s] = quantity_of(item_id) + 1
  end

  def total_count
    if @contents.empty?
      return 0
    else
      @contents.values.sum
    end
  end

  def subtotal_item(item_id)
    @contents[item_id] * (Item.find(item_id).price)
  end

  def grand_total
    @contents.sum do |id, quantity|
      (Item.find(id).price) * quantity
    end
  end

end
