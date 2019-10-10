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

  def show
    @items = []
    cart.contents.keys.each do |id|
      @items << Item.find(id.to_i)
    end
    @items
  end

  def destroy
    session.clear
    redirect_to '/cart'
  end
end
