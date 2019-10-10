class CartController < ApplicationController
  def index
    @items = cart.cart_items
  end

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    session[:cart] = cart.contents
    flash[:notice] = "Item added to cart"
    redirect_to '/items'
  end
end
