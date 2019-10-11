class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  grand_total = 0
  @cart.contents.each do |item_id, quantity|
  item = Item.find(item_id)
  subtotal = (item.price * quantity)
  grand_total += subtotal

  def show
    @cart = cart
    @grand_total = 0

    @cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      subtotal = (item.price * quantity)
      @grand_total += subtotal
    end

    if @cart.contents.any? == false
      flash.now[:notice] = "Your cart is empty"
    end
  end

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    quantity = cart.contents[item.id.to_s]

    flash[:confirm] = "#{item.name} added to cart"
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
    redirect_to items_path
  end
end
 grand_total = 0
 @cart.contents.each do |item_id, quantity|
 item = Item.find(item_id)
 subtotal = (item.price * quantity)
 grand_total += subtotal
