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
      if merchant_params.each do |key, value|
          if value == ""
            flash[:notice] = "Please enter your #{key}."
          end
        end
        render :new
      end
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if merchant.save
      redirect_to "/merchants/#{merchant.id}"
    else
      if merchant_params.each do |key, value|
          if value == ""
            flash[:notice] = "Please enter your #{key}."
          end
        end
        @merchant = merchant
        render :edit
      end
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
