class OrdersController < ApplicationController

  def new
    @items = cart.cart_items
  end

  def create
    if !customer_info.values.include?("")
      order = Order.create(total_amount: cart.grand_total)
      session[:customer] = customer_info
      cart.contents.each do |item_id, quantity|
        order.item_orders.create(item_id: item_id.to_i, quantity: quantity, city: session[:customer][:city])
      end
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = "Must fill in all fields"
      redirect_to "/orders/new"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def customer_info
    params.permit(:name, :address, :city, :state, :zip)
  end

end
