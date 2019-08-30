class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_items, only: [:new, :show]

  def new
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
    @order = Order.find(params[:id])
    session[:cart] = {}
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def set_items
    @items = Item.cart_items(@cart)
  end
end
