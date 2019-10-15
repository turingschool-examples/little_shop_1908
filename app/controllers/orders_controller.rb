class OrdersController < ApplicationController

  def new
    @items = Item.find(cart.contents.keys)
  end

  def show
    @item_orders = ItemOrder.where(order_id: params[:id])
    if @item_orders.empty?
      flash[:error] = ['Order does not exist!']
      redirect_to '/cart'
    end
  end

  def create
    user = User.create(user_params)
    if user.save
      order = user.orders.create(grand_total: cart.grand_total)

      cart.contents.each do |item_id, quantity|
        order.item_orders.create(item_id: item_id, item_quantity: quantity, subtotal: cart.subtotal(item_id))
      end
      cart.empty_contents
      session[:cart] = Hash.new(0)
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = user.errors.full_messages
      redirect_to '/orders/new'
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
