class OrdersController < ApplicationController

  def new
  end

  def create
    order = Order.create((order_params).merge(grand_total: cart.grand_total).merge(verification: Order.generate_code))
    if order.save
      order.generate_item_orders(cart)
      session[:cart] = Hash.new(0)
      redirect_to "/order/#{order.id}"
    else
      flash.now[:notice] = order.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @item_orders = ItemOrder.where(order_id: params[:id])
  end

  private
    def order_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
