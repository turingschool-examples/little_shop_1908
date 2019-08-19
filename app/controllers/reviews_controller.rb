class ReviewsController <ApplicationController

  def new
  end

  def create
    item = Item.find(params[:id])
    review = item.reviews.create(review_params)
    redirect_to "/items/#{item.id}"
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(params[:item_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)
    redirect_to "/items/#{review.item_id}"
  end

  def delete
    review = Review.find(params[:review_id])
    review.destroy
    redirect_to "/items/#{review.item_id}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end

end
