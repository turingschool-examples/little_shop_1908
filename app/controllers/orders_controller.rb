class OrdersController < ApplicationController
  def new
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
  end

  def create
    order = Order.new(order_params)
    if order.save
      cart = Cart.new(session[:cart])
      total = cart.order_total
      cart.contents.each do |item, qty|
        ItemOrder.create(order_id: order.id,
                        item_id: Item.find(item).id,
                        quantity: qty,
                        total_cost: total)
      end
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = "Please fill in all the fields"
      redirect_to '/orders/new'
    end
  end

  def show
    @cart = Cart.new(session[:cart])
    @items = Item.cart_items(@cart)
    @order = Order.find(params[:id])
    session[:cart] = {}
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
