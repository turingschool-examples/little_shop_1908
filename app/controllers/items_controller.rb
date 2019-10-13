class ItemsController<ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to "/items/#{item.id}"
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
