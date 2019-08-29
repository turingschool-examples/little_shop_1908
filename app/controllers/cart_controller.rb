class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
  end

  def create
    @item = Item.find(params[:item_id])
    session[:cart] ||= cart.contents
    if cart.limit?(@item.id)
      flash[:notice] = "There is no more inventory for this item"
    else
      cart.add_item(@item.id)
      quantity = cart.count_of(@item.id)
      flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{@item.name} in your cart."
    end
    redirect_to '/items'
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def update_quantity
    if params[:change] == 'more'
      cart.add_item(params[:item_id])
    elsif params[:change] == 'less'
      cart.remove_item(params[:item_id])
      return remove_item if cart.count_of(params[:item_id]).zero?
    end
    session[:cart] = cart.contents
    redirect_to '/cart'
  end
end
