class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])

    review = @item.reviews.create!(reviews_params)

    redirect_to "/items/#{@item.id}"
  end

  private
  def reviews_params
    params.permit(:title, :content, :rating)
  end
end
