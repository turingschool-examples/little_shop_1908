class CartController < ApplicationController

  def update_cart
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    cart.add_item(item_id_str)
    session[:cart] = cart.contents
    flash[:item_added] = "Item added to cart"

    redirect_to '/items'
  end
end
