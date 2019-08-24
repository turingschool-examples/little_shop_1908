class OrdersController < ApplicationController

  def new
    @cart = cart
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    new_order = Order.new(order_params)
    if new_order.save
      cart.contents.each do |item_id, quantity|
        item = Item.find(item_id)
        name = item.name
        merchant = item.merchant.name
        price = item.price
        subtotal = price * quantity
        new_order.order_items.create(item_id: item_id, name: name, merchant: merchant, price: price, quantity: quantity, subtotal: subtotal)
      end
      session[:cart] = nil
      flash[:notice] = "Your order has been created!"
      redirect_to "/orders/#{new_order.id}"
    else
      flash[:notice] = "You must fill out all shipping information."
      @cart = cart
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
