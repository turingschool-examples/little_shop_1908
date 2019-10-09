class MerchantsController <ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    if Merchant.exists?(params[:id])
      @merchant = Merchant.find(params[:id])
    else
      flash[:error] = 'Merchant does not exist. Redirecting to Merchant index page.'
      redirect_to '/merchants'
    end
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)

    if merchant.save
      redirect_to "/merchants"
    else
      flash.now[:error] = merchant.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)

    if @merchant.save
      redirect_to "/merchants/#{@merchant.id}"
    else
      flash.now[:error] = @merchant.errors.full_messages.to_sentence
      render :edit
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
