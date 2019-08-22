class CartController < ApplicationController

  def show
    @cart = cart
    # @contents = cart.contents
  end

  def add_item
    item = Item.find(params[:id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been added to your cart!"
    redirect_to items_path
  end

end
