class MerchantsController <ApplicationController

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
    if merchant.has_items_ordered(merchant)
      flash[:no_delete] = "We won't delete merchants with active orders pending"
      redirect_to "/merchants"
    else
      Item.delete(Item.where(merchant_id: params[:id]))
      Merchant.destroy(params[:id])
      redirect_to '/merchants'
    end
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
