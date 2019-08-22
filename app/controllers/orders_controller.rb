class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:order_id])
    @items_hash = Hash.new
    @total_cost = 0
    @order.item_orders.each do |item_order|
      @items_hash[Item.find(item_order.item_id)] = item_order.quantity
      @total_cost += item_order.total_cost
    end
  end

  def create
    if order_params.values.any? {|input| input == "" || input == "Name" || input == "Address" || input == "City" || input == "State" || input == "Zip"}
      flash[:error] = "Enter your shipping info again"
      redirect_to "/cart"
    else
      order = Order.create(order_params)
      session[:cart].each do |item_id, qty|
        item = Item.find(item_id.to_i)
        order.item_orders.create(item_id: item.id, order_id: order.id, quantity: qty, total_cost: (item.price * qty))
      end
      session[:cart] = nil
      flash[:success] = 'Your order has been placed.'
      redirect_to "/orders/#{order.id}"
    end
  end


  private
  def order_params
    params.permit(:name,:address,:city,:state,:zip)
  end

end
