class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    item.reviews.create(review_params)
    redirect_to "/items/#{params[:item_id]}"
  end

  private
  def review_params
    params.permit(Review.column_names)
  end
end
