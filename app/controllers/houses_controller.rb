class HousesController < ApplicationController

  def index
    @q = House.ransack(params[:q])
    @houses = @q.result(distinct: true)
  end

  def new 
    @house_address = HouseAddress.new
  end

  def create
    @house_address = HouseAddress.new(houses_params)
    if @house_address.valid?
      @house_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @house = House.find(params[:id])
  end

  def search
    if params[:city].present?
      @houses_search = House.where('name LIKE ?', "%#{params[:city]}%")
    else
      @houses_search = House.none
    end
  end

 private
  def houses_params
    params.require(:house_address).permit(:title, :description, :location, :checkin, :checkout, :house_category_id, :room_type_id, :price, :postal_code, :prefecture_id, :city, :house_number, :building_name, images: [])
    .merge(user_id: current_user.id)
  end
end