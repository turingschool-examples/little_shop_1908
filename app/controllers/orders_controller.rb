class OrdersController < ApplicationController

  def new
    @items = Item.find(cart.contents.keys)
  end

end
