class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.find(params[:id])
    review = @item.reviews.new(review_params)
    if review.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:notice] = "Review not submitted: Required information is missing"
      render :new
    end
  end

  private
    def review_params
      params.permit(:title,:content,:rating)
    end
end
