class HousesController < ApplicationController

  def index
    # @q = House.search(params[:q])
    # @area = @q.result
    @results = House.where('prefecture_id IN?', params[:prefecture_id])
  end

  def new 
    @house = House.new

  end

  def create
    @house = House.new(houses_params)
    if @house.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @house = House.find(params[:id])
  end

 private
  def houses_params
    params.require(:house).permit(:title, :description, :location, :checkin, :checkout, :house_category_id, :room_type_id, :price, :postal_code, :prefecture_id, :city, :house_number, :building_name, images: [])
    .merge(user_id: current_user.id)
  end
end