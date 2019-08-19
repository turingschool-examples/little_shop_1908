class ReviewsController <ApplicationController

  def new

  end

  def create
    item = Item.find(params[:id])
    review = item.reviews.create(review_params)
    redirect_to "/items/#{item.id}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end

end
