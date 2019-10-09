class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])

    review = @item.reviews.new(reviews_params)
    if review.save
      redirect_to "/items/#{@item.id}"
    else
      flash.now[:error] = "Review not created. Please fill in all fields"
      render :new
    end
  end

  private
  def reviews_params
    params.permit(:title, :content, :rating)
  end
end
