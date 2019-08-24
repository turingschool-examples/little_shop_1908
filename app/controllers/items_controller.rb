class ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    if Item.where(id: params[:id]).empty?
      flash[:no_item] = "This item doesn't exist"
      redirect_to "/items"
    else
      @item = Item.find(params[:id])
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    item.restock
    redirect_to "/items/#{item.id}"
  end

  def destroy
    item = Item.find(params[:id])
    item.reviews.destroy_all
    item.destroy
    redirect_to "/items"
  end

  # def buy_item
  #   item = Item.find(params[:id])
  #   if item.inventory <= 0
  #     flash[:fail] = "There is not enough in stock. sry."
  #   end
  #   if item.inventory > 0
  #     item.buy
  #   end
  # end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
