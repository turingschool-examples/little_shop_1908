class OrdersController < ApplicationController
  def new
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
  end

  def create
    order = Order.create!(order_params)
    redirect_to "/orders/#{order.id}"
  end

  def show
    
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
