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
      flash.now[:notice] = review.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    if Review.exists?(params[:id])
      @review = Review.find(params[:id])
      @item = Item.find(@review.item_id)
    elsif
      flash[:notice] = 'That review could not be found.'
      redirect_to '/items'
    end
  end

  def update
    @review = Review.find(params[:id])
    @item = Item.find(@review.item_id)
    if @review.update(review_params)
      redirect_to "/items/#{@item.id}"
    else
      flash.now[:notice] = @review.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to "/items/#{review.item_id}"
  end

  private
    def review_params
      params.permit(:title,:content,:rating)
    end
end
