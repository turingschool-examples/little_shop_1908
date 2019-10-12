class OrdersController < ApplicationController

  def new
    @items = Item.where(id: cart.all_items)
  end

  def create
    info_hash = order_params
    info_hash[:grand_total] = cart.grand_total
    info_hash[:creation_date] = Date.today.strftime("%m/%d/%Y")
    order = Order.create(info_hash)

    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find(params[:order_id])
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
