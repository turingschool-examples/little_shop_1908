class OrdersController < ApplicationController

  def new
    @cart = Cart.new(session[:cart])
  end

end
