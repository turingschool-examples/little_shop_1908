class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    cart = Cart.new(session[:cart])
    if item.inventory > 0
      cart.add_item(item)
      flash[:notice] = "1 #{item.name} has been added. You now have #{cart.contents[item.id.to_s]} #{item.name} in your cart."
    else
      flash[:notice] = "There are not enough #{item.name} to add to yo cart, sry."
    end
    redirect_to '/items'
  end

  def index
    cart = Cart.new(session[:cart])
    if cart.find_items_from_session.empty?
      @message = "Your cart is empty, yo."
    else
      @items_hash = cart.find_items_from_session
      @total_cost = cart.total_cost
    end
  end

  def empty
    cart = Cart.new(session[:cart])
    cart.restock_all_items_from_session
    session[:cart] = nil
    redirect_to '/cart'
  end

  def add_item
    cart = Cart.new(session[:cart])
    item = Item.find(params[:item_id])
    if item.inventory == 0
      flash[:notice] = "Eek! No more #{item.name}s left."
    else
      cart.add_item(item)
      flash[:notice] = "1 #{item.name} has been added. You now have #{cart.contents[item.id.to_s]} #{item.name} in your cart."
    end
    redirect_to '/cart'
  end

  def remove_item
    cart = Cart.new(session[:cart])
    item = Item.find(params[:item_id])
    cart.remove_one_item(item)
    redirect_to '/cart'
  end

  def remove_all_item
    cart = Cart.new(session[:cart])
    item = Item.find(params[:item_id])
    cart.remove_all_items(item)
    redirect_to '/cart'
  end

  def checkout
    cart = Cart.new(session[:cart])
    @items_hash = cart.find_items_from_session
    @total_cost = cart.total_cost
  end
end
