class CartController < ApplicationController

  def update
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] = session[:cart][item_id_str] + 1
    flash[:notice] = "This item has been added to your cart!"
    redirect_to '/items'
  end

  def index
    # <%= binding.pry %>

    # @items = Item.where(:id session[:cart])


    @items = cart.cart_items
  end

end
