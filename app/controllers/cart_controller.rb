class CartController < ApplicationController
  before_action :set_cart, only: [:add_item, :show, :remove_item, :increase, :decrease, :empty_cart]
  before_action :set_item, only: [:add_item, :remove_item, :increase, :decrease]
  after_action :set_session_cart, only: [:remove_item, :increase, :decrease, :add_item, :empty_cart]

  def add_item
    @cart.add_item(@item.id)
    flash[:notice] = "#{@item.name} added to cart."
    redirect_to '/items'
  end

  def show
    @items = Item.cart_items(@cart)
  end

  def empty_cart
    @cart.empty
    flash[:notice] = "Your cart has been emptied."
    redirect_to '/cart'
  end

  def remove_item
    @cart.remove_item(@item.id)
    redirect_to '/cart'
  end

  def increase
    if @cart.quantity_of(@item.id) < @item.inventory
      @cart.add_item(@item.id)
    else
      flash[:notice] = "Item out of stock"
    end
    redirect_to '/cart'
  end

  def decrease
    if @cart.quantity_of(@item.id) > 1
      @cart.subtract_item(@item.id)
    else
      @cart.remove_item(@item.id)
    end
    redirect_to '/cart'
  end

  private

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_session_cart
    session[:cart] = @cart.contents
  end
end
