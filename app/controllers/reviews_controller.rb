class ReviewsController < ApplicationController
  
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.create(review_params)
    if review.save
      redirect_to "/items/#{item.id}"
    else
      flash[:incomplete] = 'You must complete all fields to create a new review. Please try again.'
      redirect_to "/items/#{item.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(@review.item_id)
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)
    redirect_to "/items/#{review.item.id}"
    # ADD SAD PATH TESTING WITH FLASH MESSAGE BELOW
    # if review.save
    #   redirect_to "/items/#{item.id}"
    # else
    #   flash[:incomplete] = review.errors.full_messages
    #   redirect_to "/items/#{item.id}/reviews/new"
    # end
  end

  def destroy
   review = Review.find(params[:review_id])
   review.destroy
   redirect_to "/items/#{review.item.id}"
  end

  private
  def review_params
      params.permit(:title, :content, :rating)
  end
end
