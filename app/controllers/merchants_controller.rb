class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    merchant = Merchant.where(id: params[:id])
    if !merchant.empty?
      @merchant = merchant.first
    else
      flash[:error] = ['Merchant does not exist']
      redirect_to '/merchants'
    end
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to '/merchants'
    else
      flash[:error] = merchant.errors.full_messages
      redirect_to '/merchants/new'
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
      flash[:error] = merchant.errors.full_messages
      redirect_to "/merchants/#{merchant.id}/edit"
    end
  end

  def destroy
    Item.delete(Item.where(merchant_id: params[:id]))
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
