class OrderController <ApplicationController
  def new
    @cart = Cart.new(session[:cart])
  end

  def create
    @order = Order.create(order_params)
    redirect_to "/orders/#{@order.id}"
  end

  def show
    @order = Order.find(params[:id])
    @cart = Cart.new(session[:cart])
  end

  private

  def order_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
