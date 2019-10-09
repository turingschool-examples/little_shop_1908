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

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(reviews_params)
    if @review.save
      redirect_to "/items/#{@review.item.id}"
    else
      flash.now[:update_error] = "Review not updated. Please fill in all fields."
      render :edit
    end
  end

  private
  def reviews_params
    params.permit(:title, :content, :rating)
  end
end
