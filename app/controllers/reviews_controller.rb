class ReviewsController<ApplicationController
  before_action :set_review, only: [:index, :edit, :update, :destroy]
  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews
  end

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.new(review_params)
    if review.save
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = review.errors.full_messages
      redirect_to "/items/#{item.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @item = @review.item
  end

  def update
    if @review.update(review_params)
      redirect_to "/items/#{@review.item_id}"
    else
      flash[:error] = @review.errors.full_messages
      redirect_to "/reviews/#{@review.id}/edit"
    end
  end

  def destroy
    @review.destroy
    redirect_to "/items/#{@review.item_id}"
  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
