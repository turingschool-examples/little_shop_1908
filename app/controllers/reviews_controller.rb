class ReviewsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews
  end

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    item.reviews.create(review_params)
    redirect_to "/items/#{item.id}"
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(@review.item_id)
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)
    redirect_to "/items/#{review.item.id}"
  end

  private
  def review_params
      params.permit(:title, :content, :rating)
  end
end
