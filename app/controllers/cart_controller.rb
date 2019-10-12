class CartController < ApplicationController

  def update_cart
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:item_added] = "Item added to cart"

    redirect_to '/items'
  end

  def show
    # binding.pry
    cart_contents = session[:cart] ||= {}
    find_items = cart_contents.keys
    @items = Item.where(id: find_items)
  end
end
