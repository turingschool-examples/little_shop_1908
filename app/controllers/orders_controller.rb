class OrdersController < ApplicationController

  def new
    @items = cart.cart_items
  end



end
