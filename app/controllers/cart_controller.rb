class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update_cart
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:item_added] = "Item added to cart"

    redirect_to '/items'
  end

  def show
    cart_contents = session[:cart] ||= {}
    @items = Item.where(id: cart_contents.keys)
  end

  def empty
    cart.empty_cart
    session[:cart] = cart.contents

    redirect_to '/cart'
  end

  def remove_item
    cart.delete_item(params[:item_id])
    session[:cart] = cart.contents

    redirect_to '/cart'
  end

  def increment_item
    cart.plus_one_item(params[:item_id])
    item = Item.find(params[:item_id])
    if cart.contents == session[:cart]
      flash[:cart_inventory_error] = "Only #{pluralize(item.inventory, item.name) } in stock"
    end
    session[:cart] = cart.contents

    redirect_to '/cart'
  end
end
