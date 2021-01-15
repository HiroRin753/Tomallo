class HousesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_house, only: [:show, :edit, :update, :destroy, :map]

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
  end

  def edit
    unless current_user == @house.user
      redirect_to root_path
    endk
  end

  def update
    if @house.update(houses_params)
      redirect_to house_path(@house)
    else 
      render :edit
    end
  end

  def destroy
    unless current_user == @house.user
      redirect_to house_path
    end
    if @house.destroy
      redirect_to root_path
    end
  end

  def map
  end


 private
  def houses_params
    params.require(:house).permit(:title, :description, :location, :checkin, :checkout, :house_category_id, :room_type_id, :price, :postal_code, :prefecture_id, :city, :house_number, :building_name, images: [])
    .merge(user_id: current_user.id)
  end

  def set_house
    @house = House.find(params[:id])
  end

end