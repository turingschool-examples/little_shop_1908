class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.find(params[:id])
    @review = @item.reviews.create(review_params)
    if @review.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = "Review not created. Please fill in all fields"
      redirect_to "/items/#{@item.id}/reviews/new"
    end
  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end

end
