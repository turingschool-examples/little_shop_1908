class ReviewsController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @reviews = @item.reviews
  end
end
