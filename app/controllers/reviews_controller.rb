class ReviewsController < ApplicationController

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to "/items/#{review[:item_id]}"
  end

end