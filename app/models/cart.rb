class Cart < ApplicationController

  def self.find_items_from_session(session)
    if session.nil?
      items = Hash.new
    else
      items = Hash.new
      session.each do |item_id, qty|
      items[Item.find(item_id.to_i)] = qty
    end
    items
    end
  end

  def self.total_cost(session)
    find_items_from_session(session).sum {|item, qty| item.price * qty}
  end

  def self.total_items(session)
    if session.nil?
      return 0
    else session.values.sum
    end
  end

  def self.restock_all_items_from_session(session)
    find_items_from_session(session).each do |item, qty|
      item.inventory += qty
      if item.active? == false
        item.update(active?: true)
      end
      item.save
    end
  end

end
