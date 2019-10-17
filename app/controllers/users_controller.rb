class UsersController < ApplicationController

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to "/orders/#{user.orders.first.id}"
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip)
    end

end
