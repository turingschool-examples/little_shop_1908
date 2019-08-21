class ReviewsController <ApplicationController
  def index
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
