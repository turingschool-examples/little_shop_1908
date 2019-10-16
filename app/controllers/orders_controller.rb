class OrdersController < ApplicationController

  def new
    @items = Item.where(id: cart.all_items)
  end

  def create
    info_hash = order_params
    info_hash[:grand_total] = cart.grand_total
    info_hash[:creation_date] = Date.today.strftime("%m/%d/%Y")
    order = Order.new(info_hash)

    if order.save
      cart.contents.each do |id, quantity|
        order.item_orders.create(item_id: id, item_quantity: quantity, item_subtotal: cart.subtotal(id, quantity))
      end
      verification_code = rand.to_s[2..11]
      Order.codes[verification_code] = order.id
      flash.notice = "Your order has been placed! Verification code: #{verification_code}"
      session.delete :cart
      redirect_to "/orders/#{order.id}"

    else
      flash.notice = "Please fill out all of the fields."
      redirect_to "/orders/new"
    end
  end

  def show
    @order = Order.find(params[:order_id])
  end

  def destroy
    item_orders = ItemOrder.where(order_id: params[:order_id])
    item_orders.each do |item_order|
      item_order.destroy
    end

    order = Order.find(params[:order_id])
    order.destroy
    Order.codes.delete(Order.codes.key(order.id))

    redirect_to '/'
  end

  def edit
    @order = Order.find(params[:order_id])
  end

  def update
    order = Order.find(params[:order_id])
    order.update(order_params)

    redirect_to "/orders/#{order.id}"
  end

  def verified_show
    @order = Order.find(params[:order_id])
  end

  def search
    if Order.codes[params[:search]].nil?
      flash.notice = 'Order not found. Please try again.'
      redirect_to '/'
    else
      order = Order.find(Order.codes[params[:search]])
      redirect_to "/orders/#{order.id}/verified_order"
    end
  end

  def destroy_item
    item_order = ItemOrder.where(["order_id = ? AND item_id = ?", "#{params[:order_id]}", "#{params[:item_id]}"])
    ItemOrder.destroy(item_order.first.id)

    redirect_to "/orders/#{params[:order_id]}"
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
