class HousesController < ApplicationController

  def index
  end

  def new 
    @house = House.new
  end
  
private
  def house_params
    params.require(:house).permit(:image).merge(user_id: current_user.id)
  end
end
