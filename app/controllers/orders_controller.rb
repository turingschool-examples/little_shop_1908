class OrdersController < ApplicationController

  def new
  end

  def create
    order = Order.create((order_params).merge(grand_total: cart.grand_total))
    order.generate_item_orders(cart)
    redirect_to "/order/#{order.id}"
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
