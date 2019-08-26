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
    item = merchant.items.create(item_params)
    if item.save
      flash[:success] = "Your item has been created"
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash[:error] = item.errors.full_messages.to_sentence
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      item.restock
      flash[:success] = "Your item has been updated"
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = item.errors.full_messages.to_sentence
      redirect_to "/items/#{item.id}/edit"
    end
  end

  def destroy
    item = Item.find(params[:id])
    if session[:cart].nil?
      if item.has_been_ordered?
        flash[:no_delete] = "We won't delete items with active orders pending"
        redirect_to "/items/#{item.id}"
      else
        item.reviews.destroy_all
        item.destroy
        redirect_to "/items"
      end
    elsif session[:cart][item.id.to_s].nil?
      if item.has_been_ordered?
        flash[:no_delete] = "We won't delete items with active orders pending"
        redirect_to "/items/#{item.id}"
      else
        item.reviews.destroy_all
        item.destroy
        redirect_to "/items"
      end
    else session[:cart][item.id.to_s] > 0
      flash[:no_delete] = "We won't delete items that are in your cart."
      redirect_to "/items/#{item.id}"
    end
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
