class ItemsController < ApplicationController
  before_action :set_cart
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :set_merchant, only: [:new, :create]

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    # @cart = Cart.new(session[:cart])
    unless Item.exists?([params[:id]])
      flash[:error] = "Sorry, that item does not exist"
      redirect_to "/items"
    else
      @item = Item.find(params[:id])
      @top = @item.top_or_bottom_3_reviews(order: :desc)
      @bottom = @item.top_or_bottom_3_reviews(order: :asc)
      @average = @item.average_rating
      @sorted_reviews = @item.sort_reviews(params[:sort])
    end
  end

  def new
  end

  def create
    item = @merchant.items.new(item_params)
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:error] = item.errors.full_messages
      redirect_to "/merchants/#{@merchant.id}/items/new"
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = @item.errors.full_messages
      redirect_to "/items/#{@item.id}/edit"
    end
  end

  def destroy
    if @item.has_orders?
      flash[:error] = "Can't delete items with orders"
    else
      @item.destroy
    end
    redirect_to "/items"
  end

  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end
end
