class ReviewsController <ApplicationController

  def new
  end

  def create
    item = Item.find(params[:id])
    item.reviews.create(review_params)
    redirect_to "/items/#{item.id}"
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(params[:item_id])
  end

  def update
    review = Review.find(params[:review_id])
    if review.update(review_params)
      flash[:success] = "Your review has been updated!"
    else flash[:error] = "Retry updating your review again with better info."
    end
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
