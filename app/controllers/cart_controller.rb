class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @cart = cart

    if @cart.contents.any? == false
      flash.now[:notice] = "Your cart is empty"
    end
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

  def increase
    binding.pry
  end

  def empty_cart
    session.delete(:cart)
    redirect_to '/cart'
  end
end
