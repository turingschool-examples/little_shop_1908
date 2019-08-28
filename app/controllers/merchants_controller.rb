class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end


  def create
    Merchant.create(merchant_params)
    redirect_to "/merchants"
  #  UPDATE SAD PATH TESTING
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/merchants/#{merchant.id}"
  #  UPDATE SAD PATH TESTING
  end

  def destroy
    merchant = Merchant.find(params[:id])

    if merchant.item_orders.empty?
      Review.delete(Review.where(item_id: Item.where(merchant_id: params[:id])))
      Item.delete(Item.where(merchant_id: params[:id]))
      Merchant.destroy(params[:id])
      
      redirect_to '/merchants'
    else
      flash[:error] = "Sorry, this merchant has orders and cannot be deleted."
      redirect_to "/merchants/#{merchant.id}"
    end

  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
