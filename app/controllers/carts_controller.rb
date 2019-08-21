class CartsController < ApplicationController
  def create
  end

  def add_item
    flash[:notice] = "Item successfully added to your cart."
    redirect_to "/items"
  end
end
