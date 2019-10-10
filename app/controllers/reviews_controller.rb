class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.new(review_params)
    if review.save
      redirect_to "/items/#{params[:item_id]}"
    else
      flash.notice = "Review not created: Required information missing."
      redirect_to "/items/#{params[:item_id]}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    flash.notice = "Review updated!"

    redirect_to "/items/#{review.item.id}"
  end

  def destroy
    review = Review.find(params[:review_id])
    review.destroy

    redirect_to "/items/#{review.item.id}"
  end

  private
  def review_params
    params.permit(Review.column_names)
  end
end
