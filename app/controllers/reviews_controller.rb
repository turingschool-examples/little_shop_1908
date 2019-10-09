class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    review = @item.reviews.create(review_params)
    if review.save
      @item.reviews.create(review_params)
      redirect_to "/items/#{@item.id}"
    else
      flash.now[:error] = "Please complete all fields."
      render :new
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:review_id])
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
