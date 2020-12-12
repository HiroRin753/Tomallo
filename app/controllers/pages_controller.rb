class PagesController < ApplicationController

  def index
   @houses = House.order("created_at DESC").limit(8)
  end

  def search
    @search = House.search(params[:search])
  end

  def prefecture
    @prefecture = House.find_by(prefecture_id: params[:id])
    @prefectures = House.where(prefecture_id: params[:id]).order('created_at DESC')
  end

end
