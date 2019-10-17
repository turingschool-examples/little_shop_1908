class CartController < ApplicationController

  def update
    item = Item.find(params[:item_id])

    if params[:quantity] == 'decrease'
      cart.decrease_or_remove_item(item.id)
      flash[:success] = ["#{item.name} has been removed from your cart!"]
    else
      if cart.count_of(item.id) < item.inventory
        cart.add_item(item.id)
        flash[:success] = ["#{item.name} has been added to your cart!"]
      else
        flash[:error] = ["You have reached the maximum inventory of #{item.name}"]
      end
    end

    session[:cart] = cart.contents

    if !params[:quantity]
      redirect_to '/items'
    else
      redirect_to '/cart'
    end
  end

  def show
    @items = Item.where(id: cart.contents.keys)
  end

  def destroy
    if params[:item_id]
      cart.remove_item(params[:item_id])
      session[:cart].delete(:item_id)
    else
      cart.empty_contents
      session[:cart] = Hash.new(0)
    end
    redirect_to '/cart'
  end

end
