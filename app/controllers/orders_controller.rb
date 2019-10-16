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

  private
    def order_params
      params.permit(:name, :address, :city, :state, :zip, :search)
    end
end
