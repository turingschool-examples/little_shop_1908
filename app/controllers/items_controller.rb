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
    new_item = merchant.items.new(item_params)
    if new_item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash[:error] = new_item.errors.full_messages.to_sentence
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to "/items/#{item.id}"
    else
       flash[:error] = item.errors.full_messages.to_sentence
       redirect_to "/items/#{item.id}/edit"
    end
  end

  def destroy
    item = Item.find(params[:id])
    if !item.item_orders.empty?
      flash[:message] = 'This item has been ordered and cannot be deleted.'
      redirect_to "/items/#{item.id}"
    else
      Review.delete(Review.where(item_id: params[:id]))
      item.destroy
      redirect_to "/items"
    end
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
