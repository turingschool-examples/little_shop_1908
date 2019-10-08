class ReviewsController <ApplicationController
  def index
    if params[:merchant_id]
      @item = Item.find(params[:item_id])
      @review = @item.reviews
    else
      @reviews = Review.all
    end
  end
end
