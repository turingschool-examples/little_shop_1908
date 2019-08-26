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
    merchant = Merchant.create(merchant_params)
    if merchant.save
      redirect_to "/merchants"
    else
      flash[:incomplete_merchant] = "You have not completed the form. Please complete all three sections to create a new merchant."
      redirect_to "/merchants/new"
    end
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
    if merchant.items_orders.empty?
      Merchant.destroy(params[:id])
      redirect_to '/merchants'
    else
      flash[:delete_warning] = "This merchant has items that have been ordered. This merchant cannot be deleted at this time."
      redirect_to "/merchants/#{merchant.id}"
    end

  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
