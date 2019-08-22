class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
  end

  def add_item
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    cart.add_item(item.id)
    session[:cart] = cart.contents

    # session[:cart] ||= Hash.new(0)
    # session[:cart][item_id_str] ||= 0
    # session[:cart][item_id_str] = session[:cart][item_id_str] + 1

    quantity = session[:cart][item_id_str]
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
    redirect_to "/items"
  end
end
