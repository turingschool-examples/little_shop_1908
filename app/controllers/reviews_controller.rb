class ReviewsController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @reviews = @item.reviews
  end

  def new
    @item = Item.find(params[:id])
  end
end
