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
    if review_params.values.none? { |val| val == "" }
      item.reviews.create(review_params)
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = "Please fill in all the fields."
      redirect_to "/items/#{item.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @item = @review.item
  end

  def update
    review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to "/items/#{@review.item_id}"
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
