class HousesController < ApplicationController

  def index
  end

  def new 
    @house = House.new
  end

  def create
    @house = House.create(houses_params)
    if @house.save
      redirect_to root_path
    else
      render :new
    end
  end

private
  def houses_params
    params.require(:house).permit(:image).merge(user_id: current_user.id)
  end
end
