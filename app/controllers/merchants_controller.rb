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
    new_merchant = Merchant.new(merchant_params)
    if new_merchant.save
      redirect_to "/merchants"
    else
      flash[:error] = new_merchant.errors.full_messages.to_sentence
      redirect_to "/merchants/new"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      redirect_to "/merchants/#{merchant.id}"
    else
      flash[:error] = merchant.errors.full_messages.to_sentence
      redirect_to "/merchants/#{merchant.id}/edit"
    end
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
