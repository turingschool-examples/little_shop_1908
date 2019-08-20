class ReviewsController<ApplicationController
  before_action :set_review, only: [:index, :new, :create, :edit, :update, :destroy]
  def index
    @reviews = @item.reviews
  end

  def new
  end

  def create
    @item.reviews.create(review_params)
    redirect_to "/items/#{@item.id}"
  end

  def edit
    @item = @review.item
  end

  def update
    @review.update(review_params)
    redirect_to "/items/#{@review.item_id}"
  end

  def destroy

  end

  private

  def review_params
    params.permit(:title,:content,:rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
