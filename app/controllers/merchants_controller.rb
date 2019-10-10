class MerchantsController <ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    if Merchant.exists?(params[:id])
      @merchant = Merchant.find(params[:id])
    else
      flash[:notice] = 'That page could not be found.'
      redirect_to '/merchants'
    end
  end

  def new
  end

  def create
    Merchant.create(merchant_params)
    redirect_to "/merchants"
  end

  def edit
    if Merchant.exists?(params[:id])
      @merchant = Merchant.find(params[:id])
    else
      flash[:notice] = 'That page could not be found.'
      redirect_to '/merchants'
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/merchants/#{merchant.id}"
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
