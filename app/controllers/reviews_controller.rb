class ReviewsController <ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    review = @item.reviews.create(review_params)
    if review.save
      flash[:success] = "You have successfully posted a review"
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = review.errors.full_messages.to_sentence
      redirect_to "/items/#{@item.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    review = Review.find(params[:review_id])
    review.update(review_params)
    if review.save
      flash[:success] = "You have successfully edited a review"
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = review.errors.full_messages.to_sentence
      redirect_to "/items/#{item.id}/#{review.id}/edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to "/items/#{@review.item.id}"
  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end
end
