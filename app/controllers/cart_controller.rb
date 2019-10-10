class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    quantity = cart.count_of(item.id)
    flash.notice = "#{item.name} has been added to cart! You now have #{pluralize(quantity, item.name)} in your cart."
    redirect_to '/items'
  end

  def index
    @items = Item.where(id: cart.all_items)
  end

  def destroy
    session.delete :cart
    redirect_to '/cart'
  end

  def remove_item
    cart.remove_item(params[:item_id])
    redirect_to '/cart'
  end

  def increment_item_quantity
    if cart.contents[params[:item_id]] < Item.find(params[:item_id]).inventory
      cart.increment_item_quantity(params[:item_id])
    else
      flash.notice = "You have reached the #{Item.find(params[:item_id]).name} inventory limit."
    end
    redirect_to '/cart'
  end

  def decrement_item_quantity
    if cart.contents[params[:item_id]] >= 1
      cart.decrement_item_quantity(params[:item_id])
    else
      flash.notice = "There are no more #{Item.find(params[:item_id]).name}s to remove."
    end
    redirect_to '/cart'
  end
end
