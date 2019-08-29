class OrdersController<ApplicationController

  def new
  end

  def create
    order = Order.new(order_params)
    if order.save
      cart.item_quantity.each do |item, quantity|
        ItemOrder.create(order_id: order.id, item_id: item.id, quantity: quantity, subtotal: item.item_subtotal(quantity))
      end
      reset_session
      redirect_to "/orders/#{order.id}"
    else
      flash[:incomplete] = 'All fields must be completed to create a new order. Please try again.'
      redirect_to '/orders/new'
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
