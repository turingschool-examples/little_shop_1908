class ReviewsController < ApplicationController

  def new
    # binding.pry
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.new(review_params)
    if review.save
      review.save
      redirect_to "/items/#{item.id}"
    else
      flash[:notice] = "Please finish filling out form before submitting."
      render :new
    end
  end


  private

  def review_params
    params.permit(:title, :rating, :content, :item_id)
  end
end
