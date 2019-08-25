class OrderController <ApplicationController
  def new
    @cart = Cart.new(session[:cart])
  end
end
