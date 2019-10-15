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
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    elsif item_params[:name] == ""
      flash[:message] = "You must fill in a name"
      redirect_to "/merchants/#{merchant.id}/items/new"
    elsif item_params[:description] == ""
      flash[:message] = "You must fill in a description"
      redirect_to "/merchants/#{merchant.id}/items/new"
    elsif item_params[:price] == ""
      flash[:message] = "You must fill in a price"
      redirect_to "/merchants/#{merchant.id}/items/new"
    elsif item_params[:image] == ""
      flash[:message] = "You must fill in an image source"
      redirect_to "/merchants/#{merchant.id}/items/new"
    elsif item_params[:inventory] == ""
      flash[:message] = "You must fill in an inventory amount"
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])

    if item.update(item_params)
      redirect_to "/items/#{item.id}"
    elsif item_params[:name] == ""
      flash[:message] = "You must fill in a name"
      redirect_to "/items/#{item.id}/edit"
    elsif item_params[:description] == ""
      flash[:message] = "You must fill in a description"
      redirect_to "/items/#{item.id}/edit"
    elsif item_params[:price] == ""
      flash[:message] = "You must fill in a price"
      redirect_to "/items/#{item.id}/edit"
    elsif item_params[:image] == ""
      flash[:message] = "You must fill in an image source"
      redirect_to "/items/#{item.id}/edit"
    elsif item_params[:inventory] == ""
      flash[:message] = "You must fill in an inventory amount"
      redirect_to "/items/#{item.id}/edit"
    end
  end

  def destroy
    item = Item.find(params[:id])

    if item.orders == []
      Item.destroy(params[:id])
      cart.contents.delete(item.id.to_s)
      redirect_to "/items"
    else
      flash[:alert] = "You cannot delete an item with open orders"
      redirect_to "/items/#{item.id}"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end

end
