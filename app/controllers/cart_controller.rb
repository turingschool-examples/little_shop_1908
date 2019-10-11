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
    item = Item.find(params[:item_id])

    if item.inventory > cart.contents[item.id.to_s]
      cart.add_item(item.id)
      flash[:confirm] = "Additional #{item.name} added to cart"
      redirect_to '/cart'
    else 
      flash[:notice] = "You cannot add more of that item"
      redirect_to '/cart'
    end
  end

  def empty_cart
    session.delete(:cart)
    redirect_to '/cart'
  end
end
