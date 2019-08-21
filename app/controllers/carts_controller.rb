class CartsController < ApplicationController
  # include ActionView::Helpers::TextHelper

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
    Cart.restock_items_from_session(session[:cart])
    session[:cart] = nil
    redirect_to '/cart'
  end

end
