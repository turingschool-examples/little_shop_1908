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
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
    else
      flash[:notice] = "That page could not be found."
      redirect_to "/items"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.create(item_params)
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:notice] = item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
    else
      flash[:notice] = "That page could not be found."
      redirect_to '/items'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to "/items/#{@item.id}"
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.has_item_orders?
      flash[:notice] = "This item cannot be deleted because it has pending orders."
      redirect_to "/items/#{item.id}"
    else
      Review.delete(Review.where(item_id: params[:id]))
      Item.destroy(params[:id])
      redirect_to "/items"
    end
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
