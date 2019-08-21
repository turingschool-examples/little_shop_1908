class ReviewsController < ApplicationController

  def new
    review = Review.new
  end

  def create
    @item = Item.find(params[:id])
    review = @item.reviews.new(review_params)
    if review.save && review.rating.between?(1, 5)
      redirect_to item_path
    else
      flash[:message] = "You are missing one or more of the required fields. Please update."
      render :new
    end
  end

  def destroy
    item = Item.find(params[:id])
    review = Review.find(params[:format])
    review.destroy
    redirect_to item_path(item)
  end

  private
  def review_params
    params.permit(:title, :rating, :content)
  end

end
