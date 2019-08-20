class CartController<ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    if item.active?
      item_id_str = item.id.to_s
      session[:cart] ||= Hash.new(0)
      session[:cart][item_id_str] ||= 0
      session[:cart][item_id_str] = session[:cart][item_id_str] + 1
      quantity = session[:cart][item_id_str]
      flash[:notice] = "You now have #{pluralize(quantity, "item")} of #{item.name} in your cart."
      redirect_to "/items"
    else
      flash[:inactive_item] = "You cannot add #{item.name} to your cart because it is inactive."
      redirect_to "/items/#{item.id}"
    end
  end

  def remove_item
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.contents.delete(item.id.to_s)
    redirect_to "/cart"
  end

  def show
    @cart = Cart.new(session[:cart])
  end

  def empty
    reset_session
    redirect_to "/cart"
  end

  def increase_quantity
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    if item.inventory > @cart.contents[item.id.to_s]
      @cart.contents[item.id.to_s] += 1
    else
      flash[:limit] = "There is no more inventory for #{item.name}"
    end
    redirect_to "/cart"
  end

  def decrease_quantity
    item_id = Item.find(params[:item_id]).id
    @cart = Cart.new(session[:cart])

    if @cart.quantity_of(item_id) == 1
      @cart.contents.delete(item_id.to_s)
    else
      @cart.contents[item_id.to_s] -= 1
    end
    redirect_to "/cart"
  end
end
