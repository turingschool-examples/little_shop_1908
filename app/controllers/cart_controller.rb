class CartController<ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    flash[:success] = "You now have added #{item.name} in your cart."
    redirect_to "/items"
  end
end
