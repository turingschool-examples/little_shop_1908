class CartController < ApplicationController
  before_action :set_cart, only: [:add_item, :show, :remove_item, :increase, :decrease]
  before_action :set_item, only: [:add_item, :remove_item, :increase, :decrease]

  def add_item
    @cart.add_item(@item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "#{@item.name} added to cart."
    redirect_to '/items'
  end

  def show
    @items = Item.cart_items(@cart)
  end

  def empty_cart
    session[:cart] = {}
    flash[:notice] = "Your cart has been emptied."
    redirect_to '/cart'
  end

  def remove_item
    @cart.remove_item(@item.id)
    session[:cart] = @cart.contents
    redirect_to '/cart'
  end

  def increase
    if @cart.quantity_of(@item.id) < @item.inventory
      @cart.add_item(@item.id)
    else
      flash[:notice] = "Item out of stock"
    end
    session[:cart] = @cart.contents
    redirect_to '/cart'
  end

  def decrease
    if @cart.quantity_of(@item.id) > 1
      @cart.subtract_item(@item.id)
    else
      @cart.remove_item(@item.id)
    end
    session[:cart] = @cart.contents
    redirect_to '/cart'
  end

  private

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
