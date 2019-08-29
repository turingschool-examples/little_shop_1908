class WelcomeController < ApplicationController
  def index
    redirect_to '/items'
  end
end
