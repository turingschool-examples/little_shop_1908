class OrdersController < ApplicationController

  def new
    @items = cart.cart_items
  end

  def create
    order = Order.create(total_amount: cart.grand_total)
    session[:customer] = customer_info
    cart.contents.each do |item_id, quantity|
      order.item_orders.create(item_id: item_id.to_i, quantity: quantity)
    end
    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def customer_info
    params.permit(:name, :address, :city, :state, :zip)
  end

end
