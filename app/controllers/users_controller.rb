class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @houses = House.where(user_id: params[:id])
  end
end

