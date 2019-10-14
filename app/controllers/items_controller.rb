class ItemsController<ApplicationController

  def index
    if params[:merchant_id]
      if Merchant.exists?(id: params[:merchant_id])
        @merchant = Merchant.find(params[:merchant_id])
        @items = @merchant.items
      else
        flash.notice = 'This merchant does not exist. Please select an existing merchant.'
        redirect_to '/merchants'
      end
    else
      @items = Item.all
    end
  end

  def show
    if Item.exists?(id: params[:id])
      @item = Item.find(params[:id])
    else
      if params[:merchant_id]
        flash.notice = 'This item does not exist. Please select an existing item.'
        redirect_to "/merchants/#{params[:merchant_id]}/items"
      else
        flash.notice = 'This item does not exist. Please select an existing item.'
        redirect_to "/items"
      end
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash.notice = item.errors.full_messages.to_sentence
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      redirect_to "/items/#{item.id}"
    else
      flash.notice = item.errors.full_messages.to_sentence
      redirect_to "/items/#{item.id}/edit"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item_present = ItemOrder.pluck(:item_id).include?(item.id)
    if item_present
      flash.notice = 'Cannot delete, this item has orders in progress.'
      redirect_to "/items/#{params[:id]}"
    else
      if cart.contents.has_key?(item.id.to_s)
        cart.contents.delete(item.id.to_s)
        session[:cart] = cart.contents
      end
      Review.delete(Review.where("item_id = #{item.id}"))
      item.destroy
      redirect_to "/items"
    end
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
