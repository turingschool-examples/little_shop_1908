class OrdersController<ApplicationController

  def new
  end

  def create
    order = Order.create(order_params)
    #MOVE INTO ITEM_ORDER MODEL
    cart.item_quantity.each do |item, quantity|
      ItemOrder.new(:order_id => order.id, :item_id => item.id, :quantity => quantity, :subtotal => item.item_subtotal(quantity))
    end

    reset_session
    redirect_to "/orders/#{order.id}"

    flash[:notice] = "FILL IN YOUR ADDRESS!"
    redirect_to "/orders"
    end
  end

  def show

    @order = Order.find(params[:order_id])
  end

  private
  def order_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
