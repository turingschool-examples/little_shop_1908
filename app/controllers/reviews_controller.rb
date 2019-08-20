require 'pry'
class ReviewsController <ApplicationController

  def new
    #binding.pry
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.find(params[:id])
    review = @item.reviews.create(review_params)
    if review.save
      flash[:success] = "You have successfully posted a review"
      redirect_to "/items/#{@item.id}"
    else
      flash[:alert] = "You have not completed the form. Please complete all three sections to post a review."
      redirect_to "/items/#{@item.id}/review/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    review = Review.find(params[:review_id])
    review.update(review_params)
    if review.save
      flash[:success] = "You have successfully edited a review"
      redirect_to "/items/#{item.id}"
    else
      flash[:alert] = "You have not completed the form. Please complete all three sections to post a review."
      redirect_to "/items/#{item.id}/#{review.id}/edit"
    end
  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end
end
