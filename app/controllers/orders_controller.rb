class OrdersController < ApplicationController
  def new
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
  end

  def create
    order = Order.new(order_params)
    if order.save
      cart = Cart.new(session[:cart])
      order.create_item_orders(cart)
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = order.errors.full_messages
      redirect_to '/orders/new'
    end
  end

  def show
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
    @order = Order.find(params[:id])
    session[:cart] = {}
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
