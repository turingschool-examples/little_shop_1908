class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    if item.inventory > 0
      session[:cart][item_id_str] = session[:cart][item_id_str] + 1
      flash[:notice] = "1 #{item.name} has been added. You now have #{session[:cart][item_id_str]} #{item.name} in your cart."
    else flash[:notice] = "There are not enough #{item.name} to add to yo cart, sry."
    end
    item.buy
    redirect_to '/items'
  end

  def index
    if Cart.find_items_from_session(session[:cart]).empty?
      @message = "Your cart is empty, yo."
    else
      @items_hash = Cart.find_items_from_session(session[:cart])
      @total_cost = Cart.total_cost(session[:cart])
    end
  end

  def empty
    Cart.restock_all_items_from_session(session[:cart])
    session[:cart] = nil
    redirect_to '/cart'
  end

  def add_item
    item = Item.find(params[:item_id])
    if item.inventory == 0
      flash[:notice] = "Eek! No more #{item.name}s left."
    else
      item.buy
      session[:cart][item.id.to_s] += 1
    end
    redirect_to '/cart'
  end

  def remove_item
    item = Item.find(params[:item_id])
    item.inventory += 1
    session[:cart][item.id.to_s] -= 1
    if session[:cart][item.id.to_s] == 0
      session[:cart].delete(item.id.to_s)
    end
    item.update(active?: true)
    item.save
    redirect_to '/cart'
  end

  def remove_all_item
    item = Item.find(params[:item_id])
    qty = session[:cart][item.id.to_s]
    item.restock_qty(qty)
    item.update(active?: true)
    session[:cart].delete(item.id.to_s)
    item.save
    redirect_to '/cart'
  end

end
