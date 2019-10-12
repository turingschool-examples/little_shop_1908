class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #
  # def flash_handle(object)
  #   object.errors.full_messages.to_sentence
  # end

  helper_method :cart

  def cart
    @cart ||= Cart.new(session[:cart])
  end
end
