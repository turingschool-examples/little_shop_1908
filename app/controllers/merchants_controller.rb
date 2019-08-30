class MerchantsController <ApplicationController
  before_action :set_cart
  before_action :set_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
  end

  def show
    @top_items = @merchant.best_items
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to "/merchants"
    else
      flash[:error] = merchant.errors.full_messages
      redirect_to "/merchants/new"
    end
  end

  def edit
  end

  def update
    if @merchant.update(merchant_params)
      redirect_to "/merchants/#{@merchant.id}"
    else
      flash[:error] = @merchant.errors.full_messages
      redirect_to "/merchants/#{@merchant.id}/edit"
    end
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end
end
