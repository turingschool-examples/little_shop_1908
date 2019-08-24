class CartController < ApplicationController
  def add_item
    cart = Cart.new(session[:cart])
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:notice] = "#{item.name} added to cart."
    redirect_to '/items'
  end

  def show
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
    if @cart.contents.empty?
      flash[:error] = "Your cart is empty"
    end
  end

  def empty_cart
    session[:cart] = {}
    redirect_to '/cart'
  end

end
