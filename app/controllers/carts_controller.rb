class CartsController < ApplicationController
  # include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    if item.inventory > 0
      session[:cart][item_id_str] = session[:cart][item_id_str] + 1
      flash[:notice] = "You now have #{session[:cart][item_id_str]} #{item.name} in your cart."
    else flash[:notice] = "There are not enough #{item.name} to add to yo cart, sry."
    end
    item.buy
    redirect_to '/items'
  end

end
