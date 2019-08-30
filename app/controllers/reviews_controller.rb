class ReviewsController<ApplicationController
  before_action :set_cart
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:new, :create]

  def new
  end

  def create
    review = @item.reviews.new(review_params)
    if review.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = review.errors.full_messages
      redirect_to "/items/#{@item.id}/reviews/new"
    end
  end

  def edit
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end
end
