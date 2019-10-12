class OrdersController < ApplicationController

  def new
    @items = Item.where(id: cart.all_items)
  end


end
