class OrdersController < ApplicationController

  def new
    @items = Item.find(cart.contents.keys)
  end

  def show
    if params[:search]
      if order = Order.find_by(verification_code: params[:search])
        @order_display = OrderDisplay.new(order.id)
      else
        flash[:error] = ['Order does not exist!']
        redirect_to '/items'
      end
    else
      if order = Order.find_by(id: params[:id])
        @order_display = OrderDisplay.new(order.id)
      else
        flash[:error] = ['Order does not exist!']
        redirect_to '/cart'
      end
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      create_order(user)
    else
      flash[:error] = user.errors.full_messages
      redirect_to '/orders/new'
    end
  end

  def destroy
    if params[:item_id]
      item_order = ItemOrder.find_by(order_id: params[:order_id], item_id: params[:item_id])
      order = Order.find(params[:order_id])
      order.update_attribute(:grand_total, order.grand_total - item_order.subtotal)

      ItemOrder.delete(item_order)
      if !order.item_orders.empty?
        redirect_to "/orders/#{params[:order_id]}"
      else
        Order.delete(order)
        flash[:error] = ["Order Number #{order.verification_code} has been deleted"]
        redirect_to '/items'
      end
    else
      ItemOrder.delete(ItemOrder.where(order_id: params[:id]))
      Order.destroy(params[:id])
      redirect_to '/items'
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip)
    end

    def create_order(user)
      loop do
        rand_code = rand(10000000000).to_s
        order = user.orders.create(grand_total: cart.grand_total, verification_code: rand_code)
        if order.save
          cart.contents.each do |item_id, quantity|
            order.item_orders.create(item_id: item_id, item_quantity: quantity, subtotal: cart.subtotal(item_id))
          end
          cart.empty_contents
          session[:cart] = Hash.new(0)
          flash[:success] = ["Order Verification Code: #{rand_code}"]
          redirect_to "/orders/#{order.id}"
          break
        end
      end
    end
end
