class ReviewsController <ApplicationController

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    item.reviews.create(review_params)
    redirect_to "/items/#{item.id}"
  end

  def edit
    @item = Item.find(params[:item_id])
    @review = Review.find(params[:review_id]) # why can't we find reviews by item?
  end

  def update
    item = Item.find(params[:item_id])
    review = Review.find(params[:review_id])
    review.update(review_params)
    redirect_to "/items/#{item.id}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end

end
