class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    quantity = cart.count_of(item.id)
    flash[:notice] = "You now #{pluralize(quantity, "copy")} of #{item.name} in your cart."
    redirect_to '/items'
  end
end
