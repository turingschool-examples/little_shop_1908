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
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to "/merchants"
    else
      flash[:notice] = merchant.errors.full_messages.to_sentence
      render :new
    end
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
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to "/merchants/#{@merchant.id}"
    else
      flash[:notice] = @merchant.errors.full_messages.to_sentence
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
