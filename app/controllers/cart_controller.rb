class CartController < ApplicationController
  def update
    @item = Item.find(params[:item_id])
    cart.add_item(@item.id)
    session[:cart] = cart.contents
    flash.notice = "#{@item.name} has been added to cart!"
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
    # cookies.delete :_little_shop1906_starter_session
    session.clear
    redirect_to '/cart'
  end
end
