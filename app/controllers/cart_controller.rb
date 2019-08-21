class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    flash[:notice] = "#{item.name} added to cart."
    redirect_to '/items'
  end
end
