class OrdersController < ApplicationController

  def new
    @items = Item.find(cart.contents.keys)
  end

  def show
    @item_orders = ItemOrder.where(order_id: params[:id])
    if @item_orders.empty?
      flash[:error] = ['Order does not exist!']
      redirect_to '/cart'
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
