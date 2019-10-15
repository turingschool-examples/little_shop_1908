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
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to "/merchants"
    elsif merchant_params[:name] == ""
      flash[:message] = "You must fill in a name"
      redirect_to "/merchants/new"
    elsif merchant_params[:address] == ""
      flash[:message] = "You must fill in an address"
      redirect_to "/merchants/new"
    elsif merchant_params[:city] == ""
      flash[:message] = "You must fill in a city"
      redirect_to "/merchants/new"
    elsif merchant_params[:state] == ""
      flash[:message] = "You must fill in a state"
      redirect_to "/merchants/new"
    elsif merchant_params[:zip] == ""
      flash[:message] = "You must fill in a zip code"
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
    elsif merchant_params[:name] == ""
      flash[:message] = "You must fill in a name"
      redirect_to "/merchants/#{merchant.id}/edit"
    elsif merchant_params[:address] == ""
      flash[:message] = "You must fill in an address"
      redirect_to "/merchants/#{merchant.id}/edit"
    elsif merchant_params[:city] == ""
      flash[:message] = "You must fill in a city"
      redirect_to "/merchants/#{merchant.id}/edit"
    elsif merchant_params[:state] == ""
      flash[:message] = "You must fill in a state"
      redirect_to "/merchants/#{merchant.id}/edit"
    elsif merchant_params[:zip] == ""
      flash[:message] = "You must fill in a zip code"
      redirect_to "/merchants/#{merchant.id}/edit"
    end
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
