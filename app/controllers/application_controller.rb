class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :cart

  rescue_from ActionController::RoutingError do |exception|
    logger.error 'Routing error occurred'
    redirect_to controller: 'home', action: 'index'
    flash[:error] = "The page you have selected does not exist"
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def catch_404
    raise ActionController::RoutingError.new(params[:path])
  end
end
