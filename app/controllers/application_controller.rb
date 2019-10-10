class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 
  # def flash_handle(object)
  #   object.errors.full_messages.to_sentence
  # end
end
