class MerchantsController <ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    if Merchant.exists?(id: params[:id])
      @merchant = Merchant.find(params[:id])
    else
      flash.notice = 'This merchant does not exist. Please select an existing merchant.'
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
      flash.now.notice = merchant.errors.full_messages.to_sentence
      render :new
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
      flash.notice = merchant.errors.full_messages.to_sentence
      redirect_to "/merchants/#{merchant.id}/edit"
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    item_present = merchant.items.any? do |item|
      ItemOrder.pluck(:item_id).include?(item.id)
    end
    if item_present
      flash.notice = 'Cannot delete, this merchant has orders in progress.'
      redirect_to "/merchants/#{params[:id]}"
    else
      Item.where(merchant_id: params[:id]).each do |item|
        if cart.contents.has_key?(item.id.to_s)
          cart.contents.delete(item.id.to_s)
          session[:cart] = cart.contents
        end
      end
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
