class OrderController <ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def new
    @cart = Cart.new(session[:cart])
  end

  def create
    order = Order.create(order_params)
    if order.save
      @cart = Cart.new(session[:cart])
      @cart.contents.keys.each do |id|
        item = Item.find(id)
        item.orders << order
      end
      redirect_to "/orders/#{order.id}"
    else
      flash[:incomplete_order] = "The shipping information form is incomplete. Please fill in all five fields in order to submit order."
      redirect_to "/orders/new"
    end
  end

  def show
    @order = Order.find(params[:id])
    @cart = Cart.new(session[:cart])
  end

  private def record_not_found
    redirect_to controller: 'home', action: 'index'
    flash[:error] = "The page you have selected does not exist"
  end

  private

  def order_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
