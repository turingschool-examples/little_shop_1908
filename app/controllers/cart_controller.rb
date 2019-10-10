class CartController < ApplicationController

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = ["#{item.name} has been added to your cart!"]
    redirect_to '/items'
  end

  def show
    @items = Item.where(id: cart.contents.keys)
  end

  def destroy
    cart.empty_contents
    session[:cart] = Hash.new(0)
    redirect_to '/cart'
  end

end
