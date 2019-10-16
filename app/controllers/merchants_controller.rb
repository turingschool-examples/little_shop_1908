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
      flash.now[:notice] = merchant.errors.full_messages.to_sentence
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
      flash.now[:notice] = @merchant.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    if merchant.has_item_orders?
      flash[:notice] = "This merchant cannot be deleted because it has pending orders."
      redirect_to "/merchants/#{merchant.id}"
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
