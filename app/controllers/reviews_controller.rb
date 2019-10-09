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

  def edit
    @item = Item.find(params[:item_id])
    @review = Review.find(params[:review_id])
  end

  def update
    @item = Item.find(params[:item_id])
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      redirect_to "/items/#{@item.id}"
    else
      flash[:notice] = "Review not submitted: Required information is missing"
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    review.destroy
    redirect_to "/items/#{params[:item_id]}"
  end

  private
    def review_params
      params.permit(:title,:content,:rating)
    end
end
