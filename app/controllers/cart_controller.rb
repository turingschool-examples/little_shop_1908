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
    if params[:item_id]
      cart.remove_item(params[:item_id])
      session[:cart].delete(:item_id)
    else
      cart.empty_contents
      session[:cart] = Hash.new(0)
    end
    redirect_to '/cart'
  end

end
