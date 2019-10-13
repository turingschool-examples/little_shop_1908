class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @cart = cart

    if @cart.contents.any? == false
      flash.now[:notice] = "Your cart is empty"
      # require 'pry'; binding.pry
    end
  end

  def update
    item = Item.find(params[:item_id])
    if item.inventory > cart.contents[item.id.to_s]
      cart.add_item(item.id)
      session[:cart] = cart.contents
      quantity = cart.contents[item.id.to_s]

      flash[:confirm] = "#{item.name} added to cart"
      flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
      redirect_to items_path
    else
      flash[:notice] = "You cannot add more of that item"
      redirect_to "/items/#{item.id}"
    end
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

  def decrease
    item = Item.find(params[:item_id])
    cart.decrease_item(item.id)

    if cart.contents[item.id.to_s] > 0
      flash[:confirm] = "One #{item.name} removed from cart"
    else
      flash[:confirm] = "#{item.name} removed from cart"
    end
    redirect_to '/cart'
  end

  def empty_cart
    session.delete(:cart)
    redirect_to '/cart'
  end

  def destroy
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end
end
