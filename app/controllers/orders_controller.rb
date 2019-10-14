class OrdersController < ApplicationController

  def new
    @cart = cart
  end

  def show
    @order = Order.find(order_params[:order_id])
  end

  def create
    new_order = Order.create(order_params)
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
