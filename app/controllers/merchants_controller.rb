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
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/merchants/#{merchant.id}"
  end

  def destroy
    merchant = Merchant.find(params[:id])

    if merchant.items.all? {|item| item.orders == []}
      merchant.items.each {|item| cart.contents.delete(item.id.to_s)}
      merchant.destroy
      redirect_to '/merchants'
    else
      flash[:alert] = "You cannot delete a merchant with open orders"
      redirect_to "/merchants/#{merchant.id}"
    end
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
