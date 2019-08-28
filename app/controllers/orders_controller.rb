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

  def verified_show
    if Order.find_by(order_key: params[:order_key])
      @order = Order.find_by(order_key: params[:order_key])
      @items_hash = Hash.new
      @total_cost = 0
      @order.item_orders.each do |item_order|
        @items_hash[Item.find(item_order.item_id)] = item_order.quantity
        @total_cost += item_order.total_cost
      end
    else
      flash[:error] = "That order doesn't exist."
      redirect_back(fallback_location: "/items")
    end
  end

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

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @items_hash = Hash.new
      @total_cost = 0
      @order.item_orders.each do |item_order|
        @items_hash[Item.find(item_order.item_id)] = item_order.quantity
        @total_cost += item_order.total_cost
      end
      flash.now[:success] = "Your shipping info has been updated"
      render "verified_show"
    else
      @items_hash = Hash.new
      @total_cost = 0
      @order.item_orders.each do |item_order|
        @items_hash[Item.find(item_order.item_id)] = item_order.quantity
        @total_cost += item_order.total_cost
      end
      flash.now[:error] = @order.errors.full_messages.to_sentence
      render "verified_show"
    end
  end

  def delete
    order = Order.find(params[:order_id])
    order.item_orders.destroy_all
    order.destroy
    flash[:success] = "Your order is history!"
    redirect_to "/items"
  end

  def remove_all_item
    @order = Order.find(params[:order_id])
    item_orders = @order.item_orders.where(item_id: params[:item_id])
    item_orders.destroy_all
    @items_hash = Hash.new
    @total_cost = 0
    @order.item_orders.each do |item_order|
      @items_hash[Item.find(item_order.item_id)] = item_order.quantity
      @total_cost += item_order.total_cost
    end
    flash.now[:success] = "Item removed from your order"
    render "verified_show"
  end

  private

  def order_params
    params.permit(:name,:address,:city,:state,:zip,:order_key)
  end
end
