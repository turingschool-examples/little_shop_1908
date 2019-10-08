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

  private
  def review_params
    params.permit(Review.column_names)
  end
end
