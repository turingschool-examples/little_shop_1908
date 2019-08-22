class CartController < ApplicationController

  def index
  end

  def add_item
    cart = Cart.new(session[:format])
    item = Item.find(params[:id])
    cart.add_item(item.id)
    session[:cart] ||= Hash.new(0)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been added to your cart!"
    redirect_to items_path
  end

end
