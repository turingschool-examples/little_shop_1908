class CartController < ApplicationController
  def update
    @item = Item.find(params[:item_id])
    cart.add_item(@item)
    session[:cart] = cart.contents
    flash.notice = "#{@item.name} has been added to cart!"
    redirect_to '/items'
  end
end
