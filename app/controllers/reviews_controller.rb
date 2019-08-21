class ReviewsController <ApplicationController
  def index
    binding.pry
    if params[:item_id]
      @item = Item.find(params[:item_id])
      @reviews = @item.reviews
    else
      @reviews = Review.all
    end
  end

  def new
    @item = Item.find(params[:item_id])
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @item = Item.find(params[:item_id])
    review = @item.reviews.create(review_params)
    if review.save
      flash[:success] = "You have successfully posted a review"
      redirect_to "/items/#{@item.id}"
    else
      flash[:alert] = "You have not completed the form. Please complete all three sections to post a review."
      redirect_to "/items/#{@item.id}/reviews/new"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to "/items/#{@review.item.id}"
  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end
end
