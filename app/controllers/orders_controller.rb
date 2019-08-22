class OrdersController < ApplicationController

  def new
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
  end

end
