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

  def edit
    @item = Item.find(params[:id])
    # @review = Review.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    # binding.pry
    review = item.reviews.find_by(params[:id])
    review.update(review_params)
    redirect_to "/items/#{item.id}"
  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end

end
