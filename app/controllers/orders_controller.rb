class OrdersController < ApplicationController

  def new
  end

  def create
    order = Order.new((order_params).merge(grand_total: cart.grand_total).merge(verification: Order.generate_code))
    if order.save
      order.generate_item_orders(cart)
      session[:cart] = Hash.new(0)
      flash[:notice] = "Order created! Your order lookup code is #{order.verification}"
      redirect_to "/order/#{order.id}"
    else
      flash.now[:notice] = order.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @item_orders = ItemOrder.where(order_id: params[:id])
  end

  def verified_order
    @order = Order.search(params[:search])
    if @order.nil?
      flash[:notice] = "That order could not be found. Please ensure you have entered the correct verification code."
      redirect_to '/merchants'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      flash[:notice] = "Your changes have been saved!"
    else
      flash[:notice] = order.errors.full_messages.to_sentence
    end
    redirect_to "/verified_order/#{order.id}/edit"
  end

  def destroy_item
    item_order = ItemOrder.find(params[:item_order_id])
    order = Order.find(params[:order_id])
    item_order.destroy
    if order.item_orders.empty?
      (Order.find(params[:order_id])).destroy
      flash[:notice] = "The last item in your order was deleted, so your order has been deleted."
      redirect_to '/merchants'
    else
      flash[:notice] = "Your changes have been saved!"
      redirect_to "/verified_order/#{order.id}/edit"
    end
  end

  def destroy
    ItemOrder.delete(ItemOrder.where(order_id: params[:id]))
    (Order.find(params[:id])).destroy
    flash[:notice] = "Your order has successfully been deleted."
    redirect_to '/merchants'
  end


  private
    def order_params
      params.permit(:name, :address, :city, :state, :zip, :search)
    end
end
