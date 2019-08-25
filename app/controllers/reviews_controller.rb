class ReviewsController < ApplicationController

  def new
  end

  def create
    item = Item.find(params[:id])
    if review_params.values.any? {|input| input == ""}
      flash[:error] = "Do it right, yo."
      redirect_to "/items/#{item.id}/reviews/new-review"
    else
      flash[:success] = "Your review has been posted"
      review = item.reviews.create(review_params)
      redirect_to "/items/#{item.id}"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(params[:item_id])
  end

  def update
    review = Review.find(params[:review_id])
    if review.update(review_params)
      flash[:success] = "Your review has been updated!"
      redirect_to "/items/#{review.item_id}"
    else
      flash[:error] = "Retry updating your review again with better info."
      redirect_to "/items/#{review.item_id}/reviews/#{review.id}/edit-review"
    end
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
