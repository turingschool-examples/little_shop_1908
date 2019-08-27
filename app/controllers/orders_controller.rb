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

  # def create
  #   order = Order.new(order_params)
  #   if !order.save
  #     flash[:error] = "Enter your shipping info again"
  #     redirect_to "/cart/checkout"
  #   else
  #     session[:cart].each do |item_id, qty|
  #       item = Item.find(item_id.to_i)
  #       order.item_orders.create(item_id: item.id, order_id: order.id, quantity: qty, total_cost: (item.price * qty))
  #     end
  #     session[:cart] = nil
  #     flash[:success] = 'Your order has been placed.'
  #     redirect_to "/orders/#{order.id}"
  #   end
  # end

  def create
    address = order_params[:address] + " " + order_params[:city] + " " + order_params[:state] + " " + order_params[:zip]
    verifier = MainStreet::AddressVerifier.new(address)
    if verifier.success? && order_params[:name] != ""
      order = Order.create(order_params)
      session[:cart].each do |item_id, qty|
        item = Item.find(item_id.to_i)
        order.item_orders.create(item_id: item.id, order_id: order.id, quantity: qty, total_cost: (item.price * qty))
      end
      session[:cart] = nil
      flash[:success] = "Your order has been placed. Your order key is #{order.order_key}"
      redirect_to "/orders/#{order.id}"
    else
      flash[:address] = "Address can't be confirmed. Enter a valid address."
      redirect_to "/cart/checkout"
    end
  end

  private

  def order_params
    params.permit(:name,:address,:city,:state,:zip,:order_key)
  end
end
