class CartController < ApplicationController

  def show
    @cart = cart
  end

  def add_item
    item = Item.find(params[:id])
    if cart.available_inventory?(item)
      cart.add_item(item.id)
      session[:cart] = cart.contents
      flash[:success] = "#{item.name} has been added to your cart!"
    else
      flash[:error] = "You cannot add any more #{item.name} to your cart."
    end
      redirect_to items_path
  end

  def me_add
    item = Item.find(params[:id])
    if cart.available_inventory?(item)
      cart.add_item(item.id)
    end
    redirect_to cart_path
  end

  def me_take_away

  end

  def empty
    session[:cart] = {}
    redirect_to "/cart"
  end

  def update
    cart.contents.delete(params[:id])
    session[:cart] = cart.contents
    redirect_to "/cart"
  end

end
