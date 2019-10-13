class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show; end

  def update
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] = session[:cart][item_id_str] + 1
    quantity = session[:cart][item_id_str]
    flash[:success] = "You now have #{pluralize(quantity, 'copy')} of #{item.name} in your cart."
    redirect_to '/items'
  end

  def add_subtract
    if params[:add_subtract] == 'add'
      cart.add_item(params[:item_id])
    elsif params[:add_subtract] == 'subtract'
      cart.subtract_item(params[:item_id])
      return remove_item if cart.item_count(params[:item_id]).zero?
    end
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def destroy
    session[:cart].clear
    redirect_to '/cart'
  end
end
