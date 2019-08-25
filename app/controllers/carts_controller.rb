class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    cart.add_item(item.id)
    session[:cart] = cart.contents

    quantity = session[:cart][item_id_str]
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
    redirect_to "/items"
  end

  def show
    if cart.contents.empty?
      flash[:empty_cart] = "Your cart is empty."
    end
  end

  def delete
    reset_session
    redirect_to "/cart"
  end

  def delete_item
    item = Item.find(params[:item_id])
    session[:cart].delete(item.id.to_s)
    flash[:message] = "You have removed #{item.name} from your cart."
    redirect_to '/cart'
  end

  def increase_item
    item = Item.find(params[:item_id])
    if (session[:cart][item.id.to_s] + 1) > item.inventory
      flash[:message] = "Sorry, no more #{item.name} can be puchased as this time."
    else
      session[:cart][item.id.to_s] += 1
    end
      redirect_to '/cart'
  end
end
