class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show

  end

  def update
    item = Item.find(params[:item_id])
    if cart.count_of(item.id) < item.inventory
      cart.add_item(item.id)
      session[:cart] = cart.contents
      quantity = cart.count_of(item.id)
      flash[:notice] = "You now have #{pluralize(quantity, item.name)} in your cart."
      redirect_to '/items'
    else
      flash[:notice] = "You cannot purchase any more of those; the merchant doesn't have that many."
      redirect_to '/items'
    end
  end

  def add
    item = Item.find(params[:item_id])
    if cart.count_of(item.id) < item.inventory
      cart.add_item(item.id)
      session[:cart] = cart.contents
      quantity = cart.count_of(item.id)
      flash[:notice] = "You now have #{pluralize(quantity, item.name)} in your cart."
      redirect_to '/cart'
    else
      flash[:notice] = "You cannot purchase any more of those; the merchant doesn't have that many."
      redirect_to '/cart'
    end
  end

  def subtract
    item = Item.find(params[:item_id])
    if cart.count_of(item.id) > 1
      cart.subtract_item(item.id)
      session[:cart] = cart.contents
      quantity = cart.count_of(item.id)
      flash[:notice] = "You now have #{pluralize(quantity, item.name)} in your cart."
      redirect_to '/cart'
    else
      remove
    end
  end

  def destroy
    session[:cart] = Hash.new(0)
    redirect_to '/cart'
  end

  def remove
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end
end
