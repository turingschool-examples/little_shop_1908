class OrdersController < ApplicationController
  def new
    @items = cart.actual_items
  end


  def create
    order = Order.new(order_params)
    if order.save
      cart.contents.each do |item_id, quantity|
        item = Item.find(item_id)
        order_item = OrderItem.create!(order: order, item: item, price: item.price, quantity: quantity)
      end
      redirect_to "/orders/#{order.id}"
      else
        flash[:notice] = 'No fields can be blank.'
        redirect_to '/orders/new'
    end
  end

  def show
   @order = Order.find(params[:id])
   @cart = Cart.new(session[:cart])
 end

private

  def order_params
    params.permit(:username, :address, :city, :state, :zipcode)
  end
end
