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
   item = merchant.items.new(item_params)
   if !item.save
     flash[:notice] = "You must fill in all fields to create an item."
     redirect_to "/merchants/#{merchant.id}/items/new"
   else
     redirect_to "/merchants/#{merchant.id}/items"
   end
 end

  def edit
    @item = Item.find(params[:id])
  end

  def update
     item = Item.find(params[:id])
     if !item.update(item_params)
       flash[:notice] = "You must fill in all fields to update a item."
       redirect_to "/items/#{item.id}/edit"
     else
       item.update(item_params)
       redirect_to "/items/#{item.id}"
     end
   end

  def destroy
     item = Item.find(params[:id])
     if item.has_orders?
       item.destroy
       redirect_to '/items'
     else
       flash[:notice] = "#{item.name} cannot be deleted becasue this item is on order"
       redirect_to '/items'
     end
   end

  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end
end
