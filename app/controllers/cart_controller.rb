class CartController < ApplicationController

  def update
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] = session[:cart][item_id_str] + 1
    flash[:notice] = "This item has been added to your cart!"
    redirect_to '/items'
  end

  def index
    @items = cart.cart_items
  end

  def destroy
    session[:cart] = Hash.new(0)
    redirect_to '/cart'
  end

  def remove
    session[:cart].has_key?(params[:item_id])
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end
end
