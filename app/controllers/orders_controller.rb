class OrdersController < ApplicationController

  def new
    @items = Item.find(cart.contents.keys)
  end

  def show
    @item_orders = ItemOrder.where(order_id: params[:id])
  end

  def create
    user = User.create(user_params)
    order = user.orders.create(grand_total: cart.grand_total)

    cart.contents.each do |item_id, quantity|
      order.item_orders.create(item_id: item_id, item_quantity: quantity, subtotal: cart.subtotal(item_id))
    end
    redirect_to "/orders/#{order.id}"
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
