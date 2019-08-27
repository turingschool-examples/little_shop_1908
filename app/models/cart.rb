class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def find_items_from_session
    if @contents.nil?
      items = Hash.new
    else
      items = Hash.new
      @contents.each do |item_id, qty|
      items[Item.find(item_id.to_i)] = qty
    end
    items
    end
  end

  def total_cost
    find_items_from_session.sum {|item, qty| item.price * qty}
  end

  def total_items
    if @contents.nil?
      return 0
    else @contents.values.sum
    end
  end

  def restock_all_items_from_session
    find_items_from_session.each do |item, qty|
      item.inventory += qty
      if item.active? == false
        item.update(active?: true)
      end
      item.save
    end
  end

  def add_item(item)
    @contents[item.id.to_s] += 1
    item.buy
  end

  def remove_one_item(item)
    item.inventory += 1
    @contents[item.id.to_s] -= 1
    if @contents[item.id.to_s] == 0
      @contents.delete(item.id.to_s)
    end
    item.update(active?: true)
    item.save
  end

  def remove_all_items(item)
    item.restock(@contents[item.id.to_s])
    @contents.delete(item.id.to_s)
    item.save
  end
end
