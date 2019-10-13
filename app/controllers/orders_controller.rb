class OrdersController < ApplicationController

  def new
    cart_contents = session[:cart] ||= {}
    @items = Item.where(id: cart_contents.keys)
  end


end
