class OrdersController < ApplicationController

  def new
    @cart = cart
  end

  def show
    @order = Order.find(order_params[:order_id])
  end

  def create
    new_order = Order.new(order_params)
    if new_order.save
      cart.each do |item_id, quantity|
        item = Item.find(item_id)
        OrderItem.create(order_id: "#{new_order.id}", item_id: item_id, price: "#{item.price}", quantity: quantity)
      end
    else
      flash.now[:notice] = "Please finish filling out form before submitting."
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
