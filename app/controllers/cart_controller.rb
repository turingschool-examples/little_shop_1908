class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @cart = cart
  end

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    quantity = cart.contents[item.id.to_s]

    flash[:confirm] = "#{item.name} added to cart"
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
    redirect_to items_path
  end
end
