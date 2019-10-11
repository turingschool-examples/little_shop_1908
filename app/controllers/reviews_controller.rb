class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.create(review_params)
    if @review.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = "Review not created. Please fill in all fields"
      redirect_to "/items/#{@item.id}/reviews/new"
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @review = Review.find(params[:id])
  end

  def update
    item = Item.find(params[:item_id])
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/items/#{item.id}"
  end

  def destroy
    item = Item.find(params[:item_id])
    review = Review.find(params[:id])
    review.destroy
    redirect_to "/items/#{item.id}"

  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end

end
