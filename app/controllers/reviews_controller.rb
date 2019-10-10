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
      flash[:notice] = review.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    if Item.exists?(params[:item_id])
      @item = Item.find(params[:item_id])
      if Review.exists?(params[:review_id])
        @review = Review.find(params[:review_id])
      else
        flash[:notice] = 'That review could not be found.'
        redirect_to "/items/#{@item.id}"
      end
    else
      flash[:notice] = 'That item could not be found.'
      redirect_to '/items'
    end
  end

  def update
    @item = Item.find(params[:item_id])
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      redirect_to "/items/#{@item.id}"
    else
      flash[:notice] = review.errors.full_messages.to_sentence
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
